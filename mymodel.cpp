#include "mymodel.h"

#include <QIcon>
#include <QMimeData>
#include <QRandomGenerator>
#include <QDebug>

MyModel::MyModel(QObject *parent) : QAbstractListModel()
{
    m_roleNames[MyPixel] = "Pixel";
    m_roleNames[MyLocation_x] = "Location_x";
    m_roleNames[MyLocation_y] = "Location_y";

}


QVariant MyModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    //qDebug() << ".." << pixmaps.value(index.row());

    if (role == MyPixel)
        return pixmaps.value(index.row());
    else if (role == MyLocation_x)
        return locations.value(index.row()).x();
        //return  QString("%1-%2").arg(locations.value(index.row()).x()).arg(locations.value(index.row()).y());
    else if (role == MyLocation_y)
        return locations.value(index.row()).y();
    return QVariant();
}

QHash<int, QByteArray> MyModel::roleNames() const
{
    return m_roleNames;
}

int MyModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : pixmaps.size();
}

void MyModel::addPieces(const QString fileName, const int imgSize, const int pieceSize) //Divide the image 5x5 pieces
{
    //qDebug() << "here";
    m_PieceSize = pieceSize;
    pixmap.load(fileName);
    pixmap = pixmap.copy(
        (pixmap.width() - qMin(pixmap.width(), pixmap.height())) / 2,
        (pixmap.height() - qMin(pixmap.width(), pixmap.height())) / 2,
        qMin(pixmap.width(), pixmap.height()),
        qMin(pixmap.width(), pixmap.height())
        ).scaled(imgSize,imgSize,
        Qt::IgnoreAspectRatio, Qt::SmoothTransformation);  //Scale the image

    if (!pixmaps.isEmpty()) {
        beginRemoveRows(QModelIndex(), 0, pixmaps.size() - 1);
        pixmaps.clear();
        locations.clear();
        endRemoveRows();
    }

    for (int y = 0; y < 5; ++y) {
        for (int x = 0; x < 5; ++x) {
            QPixmap pieceImage = pixmap.copy(x*m_PieceSize, y*m_PieceSize, m_PieceSize, m_PieceSize);
            addPiece(pieceImage, QPoint(x, y));
        }
    }
}

void MyModel::addPiece(const QPixmap &pixmap, const QPoint &location)
{
    int row;
    if (QRandomGenerator::global()->bounded(2) == 1)
        row = 0;
    else
        row = pixmaps.size();

    buffer.setBuffer(&bytes);
    buffer.open(QIODevice::WriteOnly);
    pixmap.save(&buffer, "PNG");
    beginInsertRows(QModelIndex(), row, row);
    pixmaps.insert(row, bytes); //Add in the vector pixmaps
    locations.insert(row, location); //Add in the vector locations
    endInsertRows();
}

Qt::ItemFlags MyModel::flags(const QModelIndex &index) const
{
    if (index.isValid())
        return (QAbstractListModel::flags(index)|Qt::ItemIsDragEnabled);

    return Qt::ItemIsDropEnabled;
}

bool MyModel::removeRows(int row, int count, const QModelIndex &parent)
{
    if (parent.isValid())
        return false;

    if (row >= pixmaps.size() || row + count <= 0)
        return false;

    int beginRow = qMax(0, row);
    int endRow = qMin(row + count - 1, pixmaps.size() - 1);

    beginRemoveRows(parent, beginRow, endRow);

    while (beginRow <= endRow) {
        pixmaps.removeAt(beginRow);
        locations.removeAt(beginRow);
        ++beginRow;
    }

    endRemoveRows();
    return true;
}

//-----


QMimeData *MyModel::mimeData(const QModelIndexList &indexes) const
{
    QMimeData *mimeData = new QMimeData();
    QByteArray encodedData;

    QDataStream stream(&encodedData, QIODevice::WriteOnly);

    for (const QModelIndex &index : indexes) {
        if (index.isValid()) {
            QPixmap pixmap = qvariant_cast<QPixmap>(data(index, Qt::UserRole));
            QPoint location = data(index, Qt::UserRole+1).toPoint();
            stream << pixmap << location;
        }
    }

    mimeData->setData("image/x-puzzle-piece", encodedData);
    return mimeData;
}

Qt::DropActions MyModel::supportedDropActions() const
{
    return Qt::CopyAction | Qt::MoveAction;
}

QStringList MyModel::mimeTypes() const
{
    QStringList types;
    types << "image/x-puzzle-piece";
    return types;
}

bool MyModel::dropMimeData(const QMimeData *data, Qt::DropAction action,
                                   int row, int column, const QModelIndex &parent)
{
    if (!data->hasFormat("image/x-puzzle-piece"))
        return false;

    if (action == Qt::IgnoreAction)
        return true;

    if (column > 0)
        return false;

    int endRow;

    if (!parent.isValid()) {
        if (row < 0)
            endRow = pixmaps.size();
        else
            endRow = qMin(row, pixmaps.size());
    } else {
        endRow = parent.row();
    }

    QByteArray encodedData = data->data("image/x-puzzle-piece");
    QDataStream stream(&encodedData, QIODevice::ReadOnly);

    while (!stream.atEnd()) {
        QPixmap pixmap;
        QPoint location;
        stream >> pixmap >> location;

        pixmap.save(&buffer, "PNG");
        beginInsertRows(QModelIndex(), endRow, endRow);
        pixmaps.insert(endRow, bytes);
        locations.insert(endRow, location);
        endInsertRows();

        ++endRow;
    }

    return true;
}

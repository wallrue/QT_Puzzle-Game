#ifndef MYMODEL_H
#define MYMODEL_H

#include <QAbstractListModel>
#include <QPixmap>
#include <QPoint>
#include <QStringList>
#include <QVector>
#include <QBuffer>

QT_BEGIN_NAMESPACE
class QMimeData;
QT_END_NAMESPACE

class MyModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit MyModel(QObject *parent = nullptr);

    enum RoleNames {
        MyPixel = Qt::UserRole,
        MyLocation_x = Qt::UserRole+1,
        MyLocation_y = Qt::UserRole+2,
    };

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    bool removeRows(int row, int count, const QModelIndex &parent) override;

    bool dropMimeData(const QMimeData *data, Qt::DropAction action,
                      int row, int column, const QModelIndex &parent) override;
    QMimeData *mimeData(const QModelIndexList &indexes) const override;
    QStringList mimeTypes() const override;
    int rowCount(const QModelIndex &parent) const override;
    Qt::DropActions supportedDropActions() const override;

    Q_INVOKABLE void addPiece(const QPixmap &pixmap, const QPoint &location);//Called in addPieces
    Q_INVOKABLE void addPieces(const QString fileName, const int imgSize, const int pieceSize); //x From image pixmap get the piece to vector

protected:
    virtual QHash<int, QByteArray> roleNames() const override;

private:
    QVector<QPoint> locations;
    QVector<QByteArray> pixmaps;
    QPixmap pixmap;
    QPixmap pixmapQML;
    QByteArray bytes;
    QBuffer buffer;
    int m_PieceSize;

    QHash<int, QByteArray> m_roleNames; //Map for QML

};

#endif // MYMODEL_H

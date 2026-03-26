#include "pixmapbackend.h"
#include <QQmlEngine>
#include "PixmapContainer.h"

PixmapBackEnd::PixmapBackEnd(QObject *parent) : QObject(parent)
{

}

QObject *PixmapBackEnd::getPixmapContainer(QByteArray pixmapFile) const
{
    PixmapContainer * pc = new PixmapContainer();
    pc->pixmap.loadFromData(pixmapFile,"PNG");;
    Q_ASSERT(!pc->pixmap.isNull());
    QQmlEngine::setObjectOwnership(pc, QQmlEngine::JavaScriptOwnership);
    return pc;
}

#ifndef PIXMAPCONTAINER_H
#define PIXMAPCONTAINER_H

#include <QObject>
#include <QPixmap>

class PixmapContainer : public QObject
{
    Q_OBJECT
public:
    explicit PixmapContainer(QObject *parent = 0) : QObject(parent) {}
    QPixmap pixmap;
};


#endif // PIXMAPCONTAINER_H

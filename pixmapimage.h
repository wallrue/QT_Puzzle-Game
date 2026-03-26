#ifndef PIXMAPIMAGE_H
#define PIXMAPIMAGE_H

#include <QObject>
#include <QQuickPaintedItem>
#include <QPainter>
#include "PixmapContainer.h"

class PixmapImage : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit PixmapImage(QQuickItem  *parent = nullptr);
    Q_INVOKABLE void setImage(QObject *pixmapContainer);
protected:
    virtual void paint(QPainter *painter) Q_DECL_OVERRIDE;

private:
    PixmapContainer m_pixmapContainer;

};

#endif // PIXMAPIMAGE_H

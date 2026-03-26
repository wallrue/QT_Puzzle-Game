#ifndef PIXMAPBACKEND_H
#define PIXMAPBACKEND_H

#include <QObject>

class PixmapBackEnd : public QObject
{
    Q_OBJECT
public:
    explicit PixmapBackEnd(QObject *parent = nullptr);
    Q_INVOKABLE QObject* getPixmapContainer(QByteArray pixmapFile) const;
};

#endif // PIXMAPBACKEND_H

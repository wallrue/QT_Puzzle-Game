#ifndef CALPROCESS_H
#define CALPROCESS_H

#include <QObject>

class CalProcess : public QObject
{
    Q_OBJECT
public:
    explicit CalProcess(QObject *parent = nullptr);

    Q_INVOKABLE void setUpValue(qreal x0, qreal y0, qreal offset);
    Q_INVOKABLE void setUpResult();
    Q_INVOKABLE int compareProcess(int index, qreal x, qreal y);
    Q_INVOKABLE int roundWin();

private:
    QVector<qreal> correctLocation_x;
    QVector<qreal> correctLocation_y;
    QVector<int> results;
    qreal standNum;
    int sum;
    int round;

};

#endif // CALPROCESS_H

#include "calprocess.h"
#include <QDebug>

CalProcess::CalProcess(QObject *parent) : QObject(parent)
{
    round = 1;
}

//x : root.width*0.1 - root.width*0.05
//y : root.width*0.2 + root.width*0.7 + root.width*0.07 - root.width*0.1
void CalProcess::setUpValue(qreal x0, qreal y0, qreal offset)
{
    standNum = offset;
    correctLocation_x.clear();
    correctLocation_y.clear();

    for(int row = 0; row < 5; row++){
        for(int col = 0; col < 5; col++){
            correctLocation_y.append(y0 + col*offset);
            correctLocation_x.append(x0 + row*offset);
            //qDebug() << "row:" << col*5+row << " " <<  correctLocation_x[col*5+row] << correctLocation_y[col*5+row];
        }
    }


}

void CalProcess::setUpResult(){

    results.clear();
    for(int row = 0; row < 25; row++){
        results.append(0);
    }

    for(int i = 0; i < 25; i++){
        sum += results[i];
        qDebug() << "index: " << i << " - " << results[i] << "..." << round;
    }

}

int CalProcess::roundWin(){

    return round;
}

int CalProcess::compareProcess(int index, qreal x, qreal y)
{
    //qDebug() << "start compare " << index << " ." << x << " -- " << y;
    sum = 0;
    if((x > correctLocation_x.value(index) &&  x < (correctLocation_x.value(index) + standNum))
    && (y > correctLocation_y.value(index) &&  y < (correctLocation_y.value(index) + standNum))
    ){
        results[index] = 1;
    }
    else{
        results[index] = 0;
    }


    for(int i = 0; i < 25; i++){
        sum += results[i];
        //qDebug() << "index: " << i << " - " << results[i];
    }


    qDebug() << "compare " <<  results[index] << "-" << sum;

    if(sum == 25){
        round = round + 1;
        return 1;
    }
    else{
        return 0;
    }
}


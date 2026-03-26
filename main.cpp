#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "calprocess.h"
#include "mymodel.h"
#include "pixmapbackend.h"
#include "PixmapContainer.h"
#include "pixmapimage.h"
#include <QQmlContext>
#include <QQuickStyle>
//#include <VLCQtCore/Common.h>
//#include <VLCQtQml/QmlVideoPlayer.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif


    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qmlRegisterType<MyModel>("org.example", 1, 0, "MyModel");
    qmlRegisterType<CalProcess>("org.example", 1, 0, "CalProcess");

    qmlRegisterType<PixmapContainer>("org.example", 2, 0, "PixmapContainer");
    qmlRegisterType<PixmapBackEnd>("org.example", 2, 0, "PixmapBackEnd");
    qmlRegisterType<PixmapImage>("org.example", 2, 0, "PixmapImage");

//    VlcCommon::setPluginPath("C:/Users/lemin/Documents/MyGift/_Document/WebAssembly/_VLC-QT/_Document/Examples_master/qml-player/src/untitled3/VLC-Qt/bin/plugins");
//    VlcQmlVideoPlayer::registerPlugin();

    PixmapBackEnd backend;
    engine.rootContext()->setContextProperty("backend", &backend);
    QQuickStyle::setStyle("Fusion");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

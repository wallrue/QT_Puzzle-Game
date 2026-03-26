QT += quick core widgets quickcontrols2


CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        calprocess.cpp \
        main.cpp \
        mymodel.cpp \
        pixmapbackend.cpp \
        pixmapimage.cpp

RESOURCES += qml.qrc \
    mystore.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    PixmapContainer.h \
    calprocess.h \
    mymodel.h \
    pixmapbackend.h \
    pixmapimage.h


DISTFILES += \
    android-sources/AndroidManifest.xml \
    android-sources/build.gradle \
    android-sources/gradle.properties \
    android-sources/gradle/wrapper/gradle-wrapper.jar \
    android-sources/gradle/wrapper/gradle-wrapper.properties \
    android-sources/gradlew \
    android-sources/gradlew.bat \
    android-sources/res/values/libs.xml \
    android-sources/res/xml/qtprovider_paths.xml

#QMAKE_LFLAGS += -static

#LIBS += $$PWD/VLC-Qt/bin/" -llibvlc -llibvlccore -llibVLCQtCored -llibVLCQtQmld -llibVLCQtWidgetsd

#LIBS += "-L$$PWD/VLC-Qt/lib/" -lVLCQtQmld.dll -lVLCQtWidgetsd.dll -lVLCQtCored.dll

#LIBS += $$PWD/VLC-Qt/lib/libVLCQtQmld.dll.a
#LIBS += $$PWD/VLC-Qt/lib/libVLCQtWidgetsd.dll.a
#LIBS += $$PWD/VLC-Qt/lib/libVLCQtCored.dll.a

#INCLUDEPATH += $$PWD/VLC-Qt/include
#DEPENDPATH += $$PWD/VLC-Qt/include
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
ANDROID_TARGET_SDK_VERSION = 33
ANDROID_VERSION_CODE = 2
ANDROID_VERSION_NAME = 2.1

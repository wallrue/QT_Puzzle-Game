import QtQuick 2.15

Item {

    Rectangle {
        id: background
        anchors.fill: parent;
        color: "white";

        AnimatedSprite {
            id: sprite;
            anchors.centerIn: parent

            source: "qrc:/icons/images/newlogo.png";
            frameCount: 48;
            frameWidth: 220;
            frameHeight: 220;

            running: true;
            frameRate: 10;
            loops: 1;
            interpolate: true
            finishBehavior: AnimatedSprite.FinishAtFinalFrame


            onFinished:{
                animatedLogo.opacity = 0
                sprite.opacity = 0
            }

//            Behavior on opacity {
//                NumberAnimation {
//                    duration: 600
//                }
//            }
        }


    }
}

import QtQuick 2.0
import QtQuick.Dialogs
import QtQuick.Controls 2.5

ApplicationWindow {
    id: accountDialog
    minimumWidth: root.width
    minimumHeight: root.height
    flags: Qt.FramelessWindowHint
    color: "transparent"
    title: "Log In"
    maximumHeight: minimumHeight
    maximumWidth: minimumWidth


    Rectangle{
        id: backgroundDialog
        anchors.centerIn: parent
        width: accountDialog.minimumWidth/3*2.5
        height: accountDialog.minimumWidth/3*1.5
        //color: "transparent"
        radius: 15
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FFFF99" }
            GradientStop { position: 1.0; color: "#EBCE00" }
        }

        //--------- Winning Area

        Column{
            id: winningCol
            y: backgroundDialog.height/5
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: backgroundDialog.height/8
            opacity: 1

            focus: true


            Text{
                id: winningText
                color: "blue"
                text: "You won the game. \nClick to get the prize"
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: backgroundDialog.height/11
                font.bold: true
            }

            Button{
                id: winningButton
                width: backgroundDialog.width*0.4;
                height: backgroundDialog.height*0.2;

                text: "Get the prize"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    accountDialog.destroy()

                    mybackground.opacity = 0;
                    cueImage.opacity = 0;

                    videoroom.opacity = 1
                    //timerStop.start()
                    //player.play();

                }
            }
        }
    }



}

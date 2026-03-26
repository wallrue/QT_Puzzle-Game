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
            GradientStop { position: 0.0; color: "#E6F4F1" }
            GradientStop { position: 1.0; color: "#71BDEC" }
        }

        //--------- Winning Area

        Column{
            id: winningCol
            y: backgroundDialog.height/5
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: backgroundDialog.height/10
            opacity: 1

            focus: true


            Text{
                id: winningText
                color: "blue"
                text: "You are so smart.\nLet's go to the next set."
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: backgroundDialog.height/11
                font.bold: true
            }

            Button{
                id: winningButton
                width: backgroundDialog.width*0.4;
                height: backgroundDialog.height*0.2;

                text: "Next"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    setupImage();
                    calProcess.setUpResult();

                    titleText.text = "Round " + calProcess.roundWin()
                    resultImage.opacity = 0

                    accountDialog.destroy();
                }
            }
        }
    }



}

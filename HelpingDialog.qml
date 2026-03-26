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
        //--------- Helping Area
        Text{
            id: helpingText
            color: "red"
            anchors.centerIn: parent
            opacity: 1

            text: "You used your helps up\n(Touch to close the information)"
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: backgroundDialog.height/11
            font.bold: true
        }

        MouseArea{
            width: parent.width
            height: parent.height
            anchors.fill: parent

            onClicked: accountDialog.destroy()

        }
    }


//    function destroyFunction(){
//        backgroundDialog.destroy();
//    }
}

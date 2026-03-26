import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import QtQuick.Dialogs
//import QtMultimedia
import org.example 1.0
import org.example 2.0
//import VLCQt 1.0

Window {
    id: root
    width:  108*2.5 //Screen.width //
    height: 240*2.5 //Screen.height //
    visible: true
    title: "Jigsaw Puzzles"
    //visibility: Window.FullScreen

    //----- My Class
    MyModel{
        id: myModel

    }

    CalProcess{
        id: calProcess
    }


    //------------------------------- Main
    Rectangle{
        id: mybackground
        width: root.width
        height: root.height
        color: "lightgray"
        opacity: 0
        focus: false


        Row{
            id: buttonroom

            //anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.width*0.1
            anchors.top: mybackground.top
            anchors.topMargin: parent.width*0.05

            Button{
                id: btCue
                property int timeHelp;
                property var helpcomponent;
                property var helpwindow;

                width: buttonroom.width/3
                height: buttonroom.height*0.8
                anchors.left: buttonroom.left
                anchors.leftMargin:  buttonroom.width/8

                text: "Help (" + timeHelp + ")"
                onPressed: {
                    if(timeHelp > 0){
                        cueImage.opacity = 1
                        mybackground.opacity = 0.5
                    }
                    else{
                        helpcomponent = Qt.createComponent("HelpingDialog.qml")
                        helpwindow   = helpcomponent.createObject(root)
                        helpwindow.show();
                    }
                }

                onReleased: {
                    if(timeHelp > 0){
                        cueImage.opacity = 0
                        mybackground.opacity = 1
                        timeHelp--;
                    }
                }
            }

            Button{
                id: btReset
                width: buttonroom.width/3
                height: buttonroom.height*0.8
                anchors.right: buttonroom.right
                anchors.rightMargin:  buttonroom.width/8

                text: "Reset"

                onClicked: {
                    setupImage();
                    calProcess.setUpResult();
                }
            }

        }



        Rectangle{
            id: pieceArea
            width: parent.width*0.88
            height: parent.width*0.7 - parent.width*0.07 - parent.width*0.1
            anchors.top: buttonroom.bottom
            anchors.topMargin: parent.width*0.05
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"



            GridView {
                id: gridView
                anchors.fill: parent
                anchors.leftMargin: parent.width*0.05
                anchors.topMargin: parent.width*0.05
                anchors.bottomMargin: parent.width*0.05
                anchors.rightMargin: parent.width*0.03

                clip: true
                //interactive: false

                cellWidth: root.width*0.2
                cellHeight: root.width*0.2

                displaced: Transition {
                    NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
                }

                model: DelegateModel {
                    id: visualModel
                    model: myModel

                    delegate: Rectangle {
                                        id: delegateRoot

                                        width: root.width*0.18
                                        height: root.width*0.18
                                        //parent: mybackground
                                        property string colorKey
                                        color: 'lightgray'
                                        //onEntered: visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                                        //property int visualIndex: DelegateModel.itemsIndex
                                        //Binding { target: icon; property: "visualIndex"; value: visualIndex }

                                        MouseArea {
                                            id: mouseArea
                                            width: parent.width; height: parent.height
                                            anchors.centerIn: parent
                                            drag.target: icon
                                            onReleased: {
                                                parent = icon.Drag.target !== null ? icon.Drag.target : delegateRoot //Change parent to root or Drag Area
                                                //myText.text = icon.x + "-" + icon.y;

                                                if(calProcess.compareProcess(Location_x*5 + Location_y,icon.x,icon.y))
                                                {
                                                    resultImage.opacity = 1;
                                                }

                                            }
                                            Rectangle {
                                                id: icon
                                                //property int visualIndex: 0
                                                width: parent.width; height: parent.height
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter

                                                radius: 3
                                                //color: 'green'

                                                PixmapImage {
                                                    anchors.fill: parent
                                                    Component.onCompleted: this.setImage(backend.getPixmapContainer(Pixel));
                                                }

//                                                Text {
//                                                    id: id
//                                                    color: 'red'
//                                                    text: Location_x*5 + Location_y
//                                                }

                                                Drag.keys: [ delegateRoot.colorKey ]
                                                Drag.active: mouseArea.drag.active
                                                Drag.hotSpot.x: root.width*0.1
                                                Drag.hotSpot.y: root.width*0.1

                                                states: [
                                                    State {
                                                        when: mouseArea.drag.active//icon.Drag.active
                                                        ParentChange {
                                                            target: icon
                                                            parent: mybackground //pieceArea
                                                        }

                                                        AnchorChanges {
                                                            target: icon
                                                            anchors.horizontalCenter: undefined
                                                            anchors.verticalCenter: undefined
                                                        }

                                                        PropertyChanges {
                                                            target: icon
                                                            width: root.width*0.2
                                                            height: root.width*0.2
                                                        }
                                                    }
                                                ]
                                            }

                                        }
                    }


               }

            }


        }


        GridView{
            id: gridArea
            width: parent.width*0.9
            height: parent.width*0.9
            anchors.top: pieceArea.bottom
            anchors.topMargin: parent.width*0.07
            anchors.horizontalCenter: parent.horizontalCenter
            model: 25
            cellWidth: gridArea.width/5
            cellHeight: gridArea.height/5
            interactive: false

            delegate: DropArea {
                id: dragTarget
                property string colorKey
                property alias dropProxy: dragTarget
                //parent: root
                width: gridArea.width/5
                height: gridArea.height/5
                keys: [ dragTarget.colorKey ]

                Rectangle {
                    id: dropRectangle
                    anchors.fill: parent

//                    Text {
//                        text: index
//                    }


                    states: [
                        State {
                            when: dragTarget.containsDrag
                            PropertyChanges {
                                target: dropRectangle
                                color: "grey"
                            }
                        }
                    ]
                }
            }
        }

        Image {
            id: resultImage
            width: gridArea.width
            height: gridArea.height
            opacity: 0

            anchors.fill: gridArea

            source: "qrc:/images/images/round" + calProcess.roundWin() + ".jpg"

            Behavior on opacity {
                NumberAnimation {
                    duration: 1000*(!resultImage.opacity) //slow when changing to 1 but not in returning to 0
                }
            }

            onOpacityChanged: {
                if(opacity == 1){
                    if(calProcess.roundWin() === 4){
                        var component = Qt.createComponent("WinningDialog.qml")
                        var window   = component.createObject(root)
                        window.show();
                    }
                    else{
                        var helpcomponent = Qt.createComponent("NextGame.qml")
                        var helpwindow   = helpcomponent.createObject(root)
                        helpwindow.show();
                    }

                }
            }
        }

        Rectangle{
            id: titleTextRect
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            height: parent.width*0.1
            anchors.top: gridArea.bottom
            anchors.topMargin: parent.width*0.07

            Text {
                id: titleText
                text: "Round " + calProcess.roundWin()
                anchors.centerIn: parent

                font.pixelSize: parent.height*0.7
                color: 'red'
            }
        }




//        Text {
//            id: myText
//            text: root.width*0.2 + root.width*0.7 + root.width*0.07 - root.width*0.17 - root.width*0.1

//            anchors.top: buttonroom.bottom
//            anchors.topMargin: parent.width*0.07
//            anchors.horizontalCenter: parent.horizontalCenter
//        }

    }


//    Component.onCompleted: { //Game Start
//        mybackground.opacity = 0;
//        cueImage.opacity = 0;
//        videoroom.opacity = 0;

//        var component = Qt.createComponent("LoginDialog.qml")
//        var window    = component.createObject(root)
//        window.show()

//        setupImage();
//        calProcess.setUpResult();
//        calProcess.setUpValue(- root.width*0.1 + root.width*0.05, root.width*0.2 + root.width*0.7 + root.width*0.07 - root.width*0.1, root.width*0.18);
//    }

    //------------------------------- Part


    //-- Start Game
    AnimatedLogo{
        id: animatedLogo
        width: root.width;
        height: root.height;

        Behavior on opacity {
            NumberAnimation {
                duration: 800
            }
        }

        onOpacityChanged: {
            if(opacity == 0){
                mybackground.opacity = 0;
                cueImage.opacity = 0;
                videoroom.opacity = 0;

                var component = Qt.createComponent("LoginDialog.qml")
                var window    = component.createObject(root, {"width":parent.width, "height":parent.height})
                window.show()

                setupImage();
                calProcess.setUpResult();
                calProcess.setUpValue(- root.width*0.1 + root.width*0.05, root.width*0.2 + root.width*0.7 + root.width*0.07 - root.width*0.17 - root.width*0.1, root.width*0.18);

            }
        }
    }


    //-- In Game
    Image {
        id: cueImage
        anchors.centerIn: parent
        opacity: 0
        width: root.width*0.6
        height: root.width*0.6

        source: "qrc:/images/images/round" + calProcess.roundWin() + ".jpg"
    }

    function setupImage(){
        btCue.timeHelp = 3;

        if(calProcess.roundWin() === 1){
            myModel.addPieces(':/images/images/round1.jpg',root.width*0.9,root.width*0.9/5);
            resultImage.source = "qrc:/images/images/round1.jpg"
            cueImage.source = "qrc:/images/images/round1.jpg"
        }
        else if(calProcess.roundWin() === 2){
            myModel.addPieces(':/images/images/round2.jpg',root.width*0.9,root.width*0.9/5);
            resultImage.source = "qrc:/images/images/round2.jpg"
            cueImage.source = "qrc:/images/images/round2.jpg"
        }
        else if(calProcess.roundWin() === 3){
            myModel.addPieces(':/images/images/round3.jpg',root.width*0.9,root.width*0.9/5);
            resultImage.source = "qrc:/images/images/round3.jpg"
            cueImage.source = "qrc:/images/images/round3.jpg"
        }
    }


    //--Getting Prize

    Rectangle{
        id: videoroom
        width: root.width
        height: root.height
        color: 'white'
        opacity: 0

        AnimatedImage {
            id: vidwidget;
            anchors.centerIn: parent;
            source: "qrc:/video/images/outtro.gif";
        }

//        Text {
//            id: vidwidget
//            anchors.centerIn: parent
//            text: '<html><style type="text/css"></style><a href="https://extraxim.000webhostapp.com/App/Outtro.mp4">Click Me !!</a></html>'
//            onLinkActivated: Qt.openUrlExternally(link)
//        }

//        VlcVideoPlayer {
//            id: videoVLC
//            anchors.fill: parent
//            //url: "http://gift4han.tk/App/Outtro.mp4";
//        }

//        MediaPlayer {
//            id: player
//            source: "qrc:/video/images/outtro.gif"

//            onPositionChanged: {
//                if (player.position > 100 && player.duration - player.position < 100) {
//                    console.log("The End");
//                    Qt.callLater(Qt.quit);
//                }
//            }
//        }

//        VideoOutput {
//            anchors.fill: parent
//            source: player
//        }
    }

//    Timer{
//        id: timerStop
//        interval: 35000;
//        running: false;
//        repeat: false
//        onTriggered: Qt.callLater(Qt.quit);

//    }



    //Component.onCompleted: root.inputmode = false

}

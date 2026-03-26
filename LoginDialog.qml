import QtQuick 2.0
import QtQuick.Dialogs
import QtQuick.Controls 2.5

ApplicationWindow {
    id: accountDialog
    minimumWidth: root.width
    minimumHeight: root.height
    //flags: Qt.FramelessWindowHint
    color: "#B2E0D2"
    title: "Log In"
    maximumHeight: minimumHeight
    maximumWidth: minimumWidth

    Rectangle{
        id: backgroundDialog
        //anchors.fill: parent
        anchors.centerIn: parent
        width: accountDialog.minimumWidth/3*2.5
        height: accountDialog.minimumWidth/3*1.5
        //color: "blue"
        radius: 15
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#E6F4F1" }
            GradientStop { position: 1.0; color: "#71BDEC" }
        }


        //--------- Logging Area
        Column{
            id: logincol
            y: backgroundDialog.height/5
            anchors.horizontalCenter: backgroundDialog.horizontalCenter
            spacing: backgroundDialog.height/10
            opacity: 1

            //focus: true


            Text{
                id: titleName
                color: "blue"
                text: "Please input your name below: "
                font.pixelSize: backgroundDialog.height/11
                font.bold: true
            }

            Row{
                id: rowData
                spacing: backgroundDialog.width/20
                anchors.horizontalCenter: logincol.horizontalCenter

                Text{
                    id: loginpass
                    color: "black"
                    text: "Name"
                    font.pixelSize: backgroundDialog.height/11
                    anchors.top: rowData.top
                    anchors.topMargin: backgroundDialog.height/40


                }


                Row{
                    id: rowregpass
                    spacing: backgroundDialog.width/50

                    Rectangle {
                        id: loginpassRect
                        width: backgroundDialog.width*0.68; height: backgroundDialog.height/6
                        color: "lightsteelblue"
                        border.color: "gray"
                        property alias text: inputpass.text
                        property alias input: inputpass


                        TextInput {
                            id: inputpass
                            height: parent.height
                            width: parent.width
                            font.pixelSize: loginpassRect.height/2
                            anchors.fill: parent
                            anchors.margins: 4
                            //anchors.verticalCenter: parent.verticalCenter
                            focus: true
                            clip: true
                            color: "red" //"transparent" //

                            //validator: RegExpValidator { regExp: /[0-9]/ }
                            echoMode: TextInput.Normal

                            onTextChanged : {
                                //console.log("1");

                                switch(inputpass.length){
                                    case 0:
                                        inputpass.text = "";
                                        //name.text = "";
                                        break;
                                    case 1:
                                        inputpass.text = "H";
                                        //name.text = "H";
                                        break;
                                    case 2:
                                        inputpass.text = "Hâ";
                                        //name.text = "Hâ";
                                        break;
                                    case 3:
                                        inputpass.text = "Hân";
                                        //name.text = "Hân";
                                        break;
                                }

                                if(inputpass.length >= 3)
                                {
                                    inputpass.remove(3, inputpass.length);
                                }

//                                if(inputpass.length >= 3)
//                                {
//                                    inputpass.remove(3, inputpass.length);
//                                }

                            }

//                            onDisplayTextChanged : {
//                                console.log("1");

//                                switch(inputpass.displayText.length){
//                                    case 0:
//                                        inputpass.text = "";
//                                        //name.text = "";
//                                        break;
//                                    case 1:
//                                        inputpass.text = "H";
//                                        //name.text = "H";
//                                        break;
//                                    case 2:
//                                        inputpass.text = "Hâ";
//                                        //name.text = "Hâ";
//                                        break;
//                                    case 3:
//                                        inputpass.text = "Hân";
//                                        //name.text = "Hân";
//                                        break;
//                                }

//                                if(inputpass.displayText.length >= 3)
//                                {
//                                    inputpass.text = "Hân";
//                                }

////                                if(inputpass.length >= 3)
////                                {
////                                    inputpass.remove(3, inputpass.length);
////                                }

//                            }




//                            Text {
//                                id: name
//                                font.pixelSize: loginpassRect.height/2
//                                anchors.fill: parent
//                                //anchors.margins: 4
//                                anchors.verticalCenter: parent.verticalCenter
//                                color: "green"
//                                text: ""
//                            }


//                            property int count: 0
//                            Keys.onPressed: {
//                                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
//                                    btClick()
//                                    event.accepted = true;
//                                }
//                                else if (event.key === Qt.Key_Backspace || event.key === Qt.Key_Delete) {
//                                    count = (count > 0)? count - 1 : count;
//                                }
//                                else {
//                                    count = (count < 3)? count + 1 : count;
//                                }

//                                switch(count){
//                                    case 0:
//                                        name.text = "";
//                                        break;
//                                    case 1:
//                                        name.text = "H";
//                                        break;
//                                    case 2:
//                                        name.text = "Hâ";
//                                        break;
//                                    case 3:
//                                        name.text = "Hân";
//                                        break;
//                                }


//                            }


                        }

                    }

               }

            }

            Button{
                id: btLogin
                width: backgroundDialog.width*0.4;
                height: backgroundDialog.height*0.2;

                text: "Log in"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    inputpass.text = "Hân";
                    secTimer.start();
                }

            }


        }

        Timer {
            id: secTimer
            interval: 1500
            running: false
            //triggeredOnStart: true
            repeat: false

            onTriggered: {
                mybackground.opacity = 1;
                accountDialog.destroy();
                //root.contenteditable = false
            }
        }



//        //--------- Helping Area
//        Text{
//            id: helpingText
//            color: "blue"
//            anchors.centerIn: parent
//            opacity: 0

//            text: "You used your helps up"
//            font.pixelSize: backgroundDialog.height/11
//            font.bold: true
//        }


//        //--------- Winning Area

//        Column{
//            id: winningCol
//            y: backgroundDialog.height/5
//            anchors.horizontalCenter: parent.horizontalCenter
//            spacing: backgroundDialog.height/10
//            opacity: 0

//            focus: true


//            Text{
//                id: winningText
//                color: "blue"
//                text: "You won the game. Click the button below to get the prize"
//                font.pixelSize: backgroundDialog.height/11
//                font.bold: true
//            }

//            Button{
//                id: winningButton
//                width: backgroundDialog.width*0.4;
//                height: backgroundDialog.height*0.2;

//                text: "Get the prize"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                    backgroundDialog.destroy();
//                    background.state = "GettingPrize";
//                }
//            }
//        }


//        //--------- Statement
//        states: [
//            State {
//                name: "Logging"
//                PropertyChanges { target: logincol; opacity: 1}
//                PropertyChanges { target: helpingText; opacity: 0}
//                PropertyChanges { target: winningCol; opacity: 0}
//            },

//            State {
//                name: "Helping"
//                PropertyChanges { target: logincol; opacity: 0}
//                PropertyChanges { target: helpingText; opacity: 1}
//                PropertyChanges { target: winningCol; opacity: 0}
//            },

//            State {
//                name: "Winning"
//                PropertyChanges { target: logincol; opacity: 0}
//                PropertyChanges { target: helpingText; opacity: 0}
//                PropertyChanges { target: winningCol; opacity: 1}
//            }
//        ]


//    Component.onCompleted: backgroundDialog.state = root.title


    }




}

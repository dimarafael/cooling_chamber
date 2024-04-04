import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel

import QtQuick.Controls

Window {
    id: window
    width: 1280
    height: 800
    visible: true
    // visibility: window.FullScreen
    // flags: Qt.FramelessWindowHint | Qt.Dialog | Qt.WindowStaysOnTopHint
    title: qsTr("Cooling Chamber")

    readonly property int defMargin: window.height * 0.02
    readonly property color shadowColor: "#88000000"
    readonly property int fontSize1: Math.round(window.height / 30)
    property bool showSettings: false

    LinearGradient{
        anchors.fill: parent
        start: Qt.point(0,height)
        end: Qt.point(width,0)
        gradient: Gradient{
            GradientStop{
                position: 0.0;
                color: "#416f4c"
            }
            GradientStop{
                position: 0.5;
                color: "#ffffff"
            }
            GradientStop{
                position: 1.0;
                color: "#ce253c"
            }
        }
    }

    Item{
        id: itemRootContent
        anchors.fill: parent
        anchors.margins: window.defMargin

        Item {
            id: topMenu
            clip: true
            anchors.top: itemRootContent.top
            width: itemRootContent.width
            height: itemRootContent.height / 8.5
            Rectangle{
                id: topMenuBckground
                anchors.top: parent.top
                width: parent.width
                height: parent.height + window.defMargin
                color: "#416f4c"
                radius: window.defMargin
            }

            Image {
                id: logo
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: lineVerticalMachine1.left
                    margins: window.defMargin
                }
                fillMode: Image.PreserveAspectFit

                source: "img/logo.png"
            }

            Rectangle{
                id:lineVerticalMachine1
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: targetMachine1.left
                }
                height: parent.height * 0.85
                width: Math.round(height * 0.01)
                color: "white"
            }

            TargetMachine{
                id: targetMachine1
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: lineVerticalMachine2.left
                }
                width: topMenu.width / 4.5
                fontSize: window.fontSize1
                productQty: "3"
                machineNumber: "1"
            }

            Rectangle{
                id:lineVerticalMachine2
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: targetMachine2.left
                }
                height: parent.height * 0.85
                width: Math.round(height * 0.01)
                color: "white"
            }

            TargetMachine{
                id: targetMachine2
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: lineVerticalMachine3.left
                }
                width: topMenu.width / 4.5
                fontSize: window.fontSize1
                productQty: "11"
                machineNumber: "2"
            }

            Rectangle{
                id:lineVerticalMachine3
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: targetMachine3.left
                }
                height: parent.height * 0.85
                width: Math.round(height * 0.01)
                color: "white"
            }

            TargetMachine{
                id: targetMachine3
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: lineVerticalGear.left
                }
                width: topMenu.width / 4.5
                fontSize: window.fontSize1
                productQty: "14"
                machineNumber: "3"
            }

            Rectangle{
                id:lineVerticalGear
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: itemGear.left
                }
                height: parent.height * 0.85
                width: Math.round(height * 0.01)
                color: "white"
            }

            Item{
                id: itemGear
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }
                width: height * 1.5

                Rectangle{ //background if clicked
                    anchors.fill: parent
                    radius: window.defMargin
                    color: "#33ffffff"
                    visible: mouseAreaGear.pressed
                }

                MouseArea{
                    id: mouseAreaGear
                    anchors.fill: parent
                    onClicked: {
                        window.showSettings = !window.showSettings
                        itemSettings.unlocked = true //false
                        itemSettings.hideAllPopUps()
                        focus: true
                    }
                }

                Image {
                    id: imgGear
                    anchors{
                        centerIn: parent
                        margins: window.defMargin
                    }
                    fillMode: Image.PreserveAspectFit
                    source: "img/gear.svg"
                }
            }

        }
        DropShadow {
            anchors.fill: topMenu
            source: topMenu
            horizontalOffset: window.defMargin / 3
            verticalOffset: window.defMargin / 3
            radius: 8.0
            samples: 17
            color: window.shadowColor
        }

        GridView{
            id: gridViev
            anchors{
                top: topMenu.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: -( window.defMargin / 2)
                topMargin: window.defMargin / 2
            }
            cellWidth: width / 4
            cellHeight: height / 3
            interactive: false
            verticalLayoutDirection: GridView.BottomToTop

            model: ProcessModel
            delegate: ProcessItemDelegate{
                width: gridViev.cellWidth
                height: gridViev.cellHeight
                defMargin: window.defMargin
                shadowColor: window.shadowColor
                fontSize: window.fontSize1
                onStopProcess: {
                    popUpStop.index = index
                    popUpStop.visible = true
                }
                onStartProcess: {
                    ProcessModel.startProcess(index, "Prod 1", -1.7, false)
                }
            }

        }

        Rectangle{
            id: popUpGwOffline
            // visible: !ProcessModel.gatewayOnline
            visible: !ProcessModel.gatewayOnline
            width: parent.width * 0.9
            height: parent.height / 2
            radius: window.defMargin
            anchors.centerIn: parent
            color: "red"
            Text {
                id: txtGwOffline
                anchors.centerIn: parent
                font.pixelSize: window.fontSize1 * 3
                color: "white"
                text: qsTr("Sensors gateway offline!")
            }
        }

        Rectangle{
            id: popUpStop
            width: parent.width / 2
            height: parent.height / 2
            radius: window.defMargin
            color: "white"
            anchors.centerIn: parent
            visible: false

            property int index: 0

            Text{
                id: txtPopUpStopLine1
                width: parent.width
                height: parent.height / 4
                anchors.top: parent.top
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                color: "#416f4c"
                font.pixelSize: window.fontSize1 * 2
                text: "Stop?"
            }
            Text{
                id: txtPopUpStopLine2
                width: parent.width
                height: parent.height / 4
                anchors.top: txtPopUpStopLine1.bottom
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                color: "#416f4c"
                font.pixelSize: window.fontSize1 * 2
                text: "Place" + (popUpStop.index + 1)
            }

            Item {
                id: itemPopUpStopLine3
                height: parent.height / 2
                width: parent.width * 0.85
                anchors.top: txtPopUpStopLine2.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: btnPopUpStopCancel
                    height: window.height / 10
                    width: window.width / 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    color: mouseAreaStopCancel.pressed? "red":"#d83324"
                    radius: height / 2
                    Text{
                        anchors.centerIn: parent
                        font.pixelSize: window.fontSize1
                        color: "white"
                        text: "CANCEL"
                    }

                    MouseArea{
                        id: mouseAreaStopCancel
                        anchors.fill: parent
                        onClicked: {
                            popUpStop.visible = false
                        }
                    }
                }

                Rectangle{
                    id: btnPopUpStopOk
                    height: window.height / 10
                    width: window.width / 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color: mouseAreaStopOk.pressed? "green":"#416f4c"
                    radius: height / 2
                    Text{
                        anchors.centerIn: parent
                        font.pixelSize: window.fontSize1
                        color: "white"
                        text: "STOP"
                    }
                    MouseArea{
                        id: mouseAreaStopOk
                        anchors.fill: parent
                        onClicked: {
                            ProcessModel.stopProcess(popUpStop.index)
                            popUpStop.visible = false
                        }
                    }
                }
            }
        }


        SettingsPanel {
            id: itemSettings
            width: parent.width
            height: parent.height - topMenu.height
            x: 0
            y: window.showSettings ? topMenu.height + window.defMargin : window.height
            defMargin: window.defMargin

            Behavior on y{
                NumberAnimation{
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
            onHidePanel: {
                window.showSettings = false
            }
        }

    } // Item root content

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}

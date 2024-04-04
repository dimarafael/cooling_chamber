import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel

import QtQuick.Controls

Rectangle{
    id: root
    width: 200
    height: 200
    color: "white"
    property int index: 0
    property int buttonWidth: 50
    property int fontSize: 30
    property int targetLine: 1 // 1, 2, 3

    Text{
        id: txtLine1
        width: parent.width
        height: parent.height / 8
        anchors.top: parent.top
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        color: "#416f4c"
        font.pixelSize: root.fontSize * 2
        text: "Start process on place " + (root.index + 1)
    }

    ListView{
        id: productsList
        anchors.top: txtLine1.bottom
        anchors.topMargin: parent.height / 100
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height / 2
        clip: true
        ScrollBar.vertical: ScrollBar { }

        Rectangle{
            anchors.fill: parent
            color: "lightgray"
        }
    }

    Item{
        id: itemLine3
        anchors.top: productsList.bottom
        width: parent.width * 0.9
        height: parent.height * 0.18
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: targetBg
            width: parent.width
            height: root.buttonWidth * 0.3
            anchors.centerIn: parent
            color: "lightgrey"
            radius: height / 2
            MouseArea{
                id: mouseAreaTarget1
                height: parent.height
                width: parent.width / 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                onClicked: root.targetLine = 1
            }
            MouseArea{
                id: mouseAreaTarget2
                height: parent.height
                width: parent.width / 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: root.targetLine = 2
            }
            MouseArea{
                id: mouseAreaTarget3
                height: parent.height
                width: parent.width / 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                onClicked: root.targetLine = 3
            }
        }
        Rectangle{
            id: btnTarget
            height: root.buttonWidth * 0.3
            width: root.buttonWidth
            x: {
                if(root.targetLine === 1) return 0
                if(root.targetLine === 2) return (targetBg.width / 2) - width / 2
                if(root.targetLine === 3) return targetBg.width - width
            }
            anchors.verticalCenter: targetBg.verticalCenter
            color: "#3E95F9"
            radius: height / 2
            Behavior on x{
                NumberAnimation{
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Text{
            id: txtTarget1
            anchors.left: parent.left
            anchors.leftMargin: root.buttonWidth / 2 - root.fontSize / 2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.fontSize * 2
            font.bold: true
            color: (root.targetLine === 1)?"white":"#3E95F9"
            text: "1"
        }
        Text{
            id: txtTarget2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.fontSize * 2
            font.bold: true
            color: (root.targetLine === 2)?"white":"#3E95F9"
            text: "2"
        }
        Text{
            id: txtTarget3
            anchors.right: parent.right
            anchors.rightMargin: root.buttonWidth / 2 - root.fontSize / 2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.fontSize * 2
            font.bold: true
            color: (root.targetLine === 3)?"white":"#3E95F9"
            text: "3"
        }
    }

    Item{
        id: itemLine4
        anchors.top: itemLine3.bottom
        width: parent.width * 0.9
        height: parent.height * 0.18
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle{
            id: btnCancel
            height: root.buttonWidth * 0.3
            width: root.buttonWidth
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            color: mouseAreaCancel.pressed? "red":"#d83324"
            radius: height / 2
            Text{
                anchors.centerIn: parent
                font.pixelSize: root.fontSize
                color: "white"
                text: "CANCEL"
            }

            MouseArea{
                id: mouseAreaCancel
                anchors.fill: parent
                onClicked: {
                    root.visible = false
                }
            }
        }

        Rectangle{
            id: btnStart
            height: root.buttonWidth * 0.3
            width: root.buttonWidth
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            color: mouseAreaOk.pressed? "green":"#416f4c"
            radius: height / 2
            Text{
                anchors.centerIn: parent
                font.pixelSize: root.fontSize
                color: "white"
                text: "START"
            }
            MouseArea{
                id: mouseAreaOk
                anchors.fill: parent
                onClicked: {
                    // popUpStop.stop(popUpStop.index)
                    root.visible = false
                }
            }
        }
    }
}

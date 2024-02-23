import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel

import QtQuick.Controls

Item {
    id: root

    property int fontSize: 10
    property alias productQty: textTargetMachine.text
    property alias machineNumber: textMachineNumber.text

    Text {
        id: textTargetMachine
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: root.fontSize
        }
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: root.fontSize * 2
        color: "white"
        text: "18"
    }

    Text {
        id: textTargetArrowMachine
        anchors.right: imgMachine.left
        anchors.rightMargin: root.fontSize
        anchors.verticalCenter: parent.verticalCenter
        text: String.fromCodePoint(0x21D2)
        font.pixelSize: root.fontSize
        color: "white"
    }

    Image {
        id: imgMachine
        anchors{
            top: parent.top
            bottom: parent.bottom
            right: itemMachineNumber.left
            margins: Math.round(root.fontSize / 1.5)
            rightMargin: 0
        }
        fillMode: Image.PreserveAspectFit
        smooth: false
        source: "img/machine.svg"
    }
    Item {
        id: itemMachineNumber
        anchors{
            top: parent.top
            right: parent.right
        }
        height: parent.height * 0.7
        width: parent.height * 0.7

        Text {
            id: textMachineNumber
            anchors.fill: parent
            anchors.leftMargin: Math.round(root.fontSize / 3)
            font.pixelSize: root.fontSize * 1.5
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: "3"
        }
    }
}

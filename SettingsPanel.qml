import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel

import QtQuick.Controls

Item{
    id: root
    property int defMargin: 5
    property bool unlocked: false

    DropShadow {
        anchors.fill: root
        source: root
        horizontalOffset: root.defMargin / 3
        verticalOffset: root.defMargin / 3
        radius: 8.0
        samples: 17
        color: "#88000000"
    }

    Rectangle{
        width: parent.width
        height: parent.height + root.defMargin
        color: "white"
        radius: root.defMargin
    }

    Item{
        id: itemPass
        visible: !root.unlocked
        anchors.fill: parent

    }
}

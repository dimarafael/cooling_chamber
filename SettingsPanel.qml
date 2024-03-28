import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel
import QtQuick.Controls
import com.kometa.ProductsModel

Item{
    id: root
    property int defMargin: 5
    property bool unlocked: false
    property int fontSize: 30

    function checkPassword(){
        if(txtFldPass.text === "123"){
            root.unlocked = true
            root.focus = true
        }
        txtFldPass.text = ""
    }

    MouseArea{ // Hidden area for close application
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 40
        height: 40

        onClicked: {
            Qt.callLater(Qt.quit)
        }
    }

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
        color: "lightgray"
        radius: root.defMargin
    }

    Item{ // show content
        id: itemRootContent
        visible: root.unlocked
        anchors.fill: parent

        Text{
            id: textLabelRootContent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height / 100
            text: "Edit products recipes"
            color: "#416f4c"
            font.pixelSize: root.fontSize * 2
        }

        ListView{
            id: listProducts
            anchors.top: textLabelRootContent.bottom
            anchors.topMargin: parent.height / 100
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.9
            height: parent.height * 0.7
            clip: true
            ScrollBar.vertical: ScrollBar { }

            model: ProductsModel

            delegate: Item {
                id: delegate
                height: root.fontSize * 1.4
                width: listProducts.width
                required property string productName
                required property real setpoint
                required property bool coolMode
                Rectangle{
                    anchors.fill: parent
                    color: "blue"
                    Text {
                        text: delegate.productName
                    }
                }
            }
        }

    }



    Item{ // show password field
        id: itemPass
        visible: !root.unlocked
        anchors.fill: parent

        Text{
            id: textLabelPass
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height / 4
            text: "Enter password"
            color: "#416f4c"
            font.pixelSize: root.fontSize

        }

        TextField{
            id: txtFldPass
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: textLabelPass.bottom
            anchors.topMargin: height / 3
            width: parent.width / 4
            height: root.fontSize * 1.4
            inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoTextHandles // | hide selection handles
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: root.fontSize
            echoMode: TextInput.Password
            onAccepted: root.checkPassword()
        }


    }
}

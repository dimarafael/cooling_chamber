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
    property color textColor: "black" //"#bb000000"
    property int indexForDeleteEdit: 0
    property string nameForDeleteEdit: ""

    signal hidePanel()

    function hideAllPopUps(){
        popUpDelete.visible = false
        popUpAddEdit.visible = false
    }

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
        id: bgRectangle
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
            height: parent.height * 0.65
            clip: true
            ScrollBar.vertical: ScrollBar { }

            model: ProductsModel

            delegate: Item {
                id: delegate
                height: listProducts.height / 5
                width: listProducts.width
                required property string productName
                required property real setpoint
                required property bool coolMode
                required property int index

                Rectangle{
                    anchors.fill: parent
                    border.color: "grey"
                    border.width: 1
                    color: bgRectangle.color
                    Text {
                        id: txtProductName
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: parent.height / 4
                        font.pixelSize: root.fontSize
                        color: root.textColor
                        text: delegate.productName
                    }

                    Text{
                        id:txtProductSetpoint
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: itemModeIcon.left
                        font.pixelSize: root.fontSize
                        color: root.textColor
                        text: delegate.setpoint.toFixed(1)  + "℃"
                    }

                    Item{
                        id: itemModeIcon
                        anchors{
                            top: parent.top
                            right: itemEdit.left
                            bottom: parent.bottom
                        }
                        width: height * 2

                        Image {
                            id: imgModeIcon
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            fillMode: Image.PreserveAspectFit
                            source: delegate.coolMode?"img/mode_1.svg":"img/mode_0.svg"
                            sourceSize.height: height
                            smooth: false
                        }
                        ColorOverlay{
                            anchors.fill: imgModeIcon
                            source:imgModeIcon
                            color:"black"
                            antialiasing: true
                        }
                    }

                    Item{
                        id: itemEdit
                        anchors{
                            top: parent.top
                            bottom: parent.bottom
                            right: itemDelete.left
                        }
                        width: height * 1.5

                        Rectangle{ //background if clicked
                            anchors.fill: parent
                            color: "#33ffffff"
                            visible: mouseAreaEdit.pressed
                        }

                        MouseArea{
                            id: mouseAreaEdit
                            anchors.fill: parent
                            onClicked: {
                                focus: true
                                console.log("Edit " + delegate.index)
                                txtEditLine1.text = delegate.productName
                                txtEditLine2.text = delegate.setpoint.toFixed(1)
                                popUpAddEdit.mode = delegate.coolMode
                                popUpAddEdit.index = delegate.index
                                popUpAddEdit.isEdit = true
                                popUpAddEdit.visible = true
                            }
                        }

                        Image {
                            id: imgEdit
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.margins: parent.height / 7
                            fillMode: Image.PreserveAspectFit
                            sourceSize.height: height
                            source: "img/edit.svg"
                        }
                    }

                    Item{
                        id: itemDelete
                        anchors{
                            top: parent.top
                            bottom: parent.bottom
                            right: parent.right
                        }
                        width: height * 1.5

                        Rectangle{ //background if clicked
                            anchors.fill: parent
                            color: "#33ffffff"
                            visible: mouseAreaDelete.pressed
                        }

                        MouseArea{
                            id: mouseAreaDelete
                            anchors.fill: parent
                            onClicked: {
                                focus: true
                                console.log("Delete " + delegate.index)
                                root.indexForDeleteEdit = delegate.index
                                root.nameForDeleteEdit = delegate.productName
                                popUpDelete.visible = true
                            }
                        }

                        Image {
                            id: imgDelete
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.margins: parent.height / 8
                            fillMode: Image.PreserveAspectFit
                            sourceSize.height: height
                            source: "img/trash.svg"
                        }
                    }

                }
            }
        }
        Item{
            width: parent.width * 0.9
            height: root.height - listProducts.height - listProducts.y
            anchors.top: listProducts.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btnCanceSettings
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                color: mouseCancelSettings.pressed? "red":"#d83324"
                radius: height / 2
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: root.fontSize
                    color: "white"
                    text: "CANCEL"
                }

                MouseArea{
                    id: mouseCancelSettings
                    anchors.fill: parent
                    onClicked: {
                        root.unlocked = false
                        root.hideAllPopUps()
                        root.hidePanel()
                    }
                }
            }

            Rectangle{
                id: btnAddSettings
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: mouseAddSettings.pressed? "blue":"#3E95F9"
                radius: height / 2
                Text{
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.topMargin: -(root.fontSize * 0.6)
                    font.pixelSize: root.fontSize * 3
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    text: "+"
                }

                MouseArea{
                    id: mouseAddSettings
                    anchors.fill: parent
                    onClicked: {
                        txtEditLine1.text = ""
                        txtEditLine2.text = -1
                        popUpAddEdit.mode = false
                        popUpAddEdit.index = 0
                        popUpAddEdit.isEdit = false
                        popUpAddEdit.visible = true
                    }
                }
            }
        }

    }

    Rectangle{
        id:popUpBG
        x: 0
        y: 0
        width: root.width
        height: root.height + root.defMargin
        radius: root.defMargin
        color: "gray"
        opacity: 0.7
        visible: popUpDelete.visible | popUpAddEdit.visible
        MouseArea{
            anchors.fill: parent
            onClicked: focus=true
        }
    }

    DropShadow {
        anchors.fill: popUpDelete
        source: popUpDelete
        horizontalOffset: root.defMargin / 3
        verticalOffset: root.defMargin / 3
        radius: 8.0
        samples: 17
        color: "#88000000"
        visible: popUpDelete.visible
    }
    Rectangle{
        id: popUpDelete
        width: parent.width / 2
        height: parent.height / 2
        radius: root.defMargin
        color: "white"
        anchors.centerIn: parent
        visible: false
        Text{
            id: txtPopUpDeleteLine1
            width: parent.width
            height: parent.height / 4
            anchors.top: parent.top
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            color: "#416f4c"
            font.pixelSize: root.fontSize * 2
            text: "Delete?"
        }
        Text{
            id: txtPopUpDeleteLine2
            width: parent.width
            height: parent.height / 4
            anchors.top: txtPopUpDeleteLine1.bottom
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            color: "#416f4c"
            font.pixelSize: root.fontSize * 2
            text: root.nameForDeleteEdit
        }

        Item {
            id: itemPopUpDeleteLine3
            height: parent.height / 2
            width: parent.width * 0.85
            anchors.top: txtPopUpDeleteLine2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btnPopUpDeleteCancel
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                color: mouseAreaDeleteCancel.pressed? "red":"#d83324"
                radius: height / 2
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: root.fontSize
                    color: "white"
                    text: "CANCEL"
                }

                MouseArea{
                    id: mouseAreaDeleteCancel
                    anchors.fill: parent
                    onClicked: {
                        popUpDelete.visible = false
                    }
                }
            }

            Rectangle{
                id: btnPopUpDeleteOk
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                color: mouseAreaDeleteOk.pressed? "green":"#416f4c"
                radius: height / 2
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: root.fontSize
                    color: "white"
                    text: "DELETE"
                }
                MouseArea{
                    id: mouseAreaDeleteOk
                    anchors.fill: parent
                    onClicked: {
                        ProductsModel.remove(root.indexForDeleteEdit)
                        popUpDelete.visible = false
                    }
                }
            }
        }
    }

    Rectangle{
        id: popUpAddEdit
        width: parent.width / 2
        height: parent.height * 0.7
        radius: root.defMargin
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: height / 8
        visible: false
        property bool mode: false
        property int index: 0
        property bool isEdit: false

        Item {
            id: popUpEditLine1
            width: parent.width
            height: parent.height / 4
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            TextField{
                id: txtEditLine1
                width: parent.width * 0.8
                height: parent.height * 0.6
                anchors.centerIn: parent
                inputMethodHints: Qt.ImhNoTextHandles // | hide selection handles
                font.pixelSize: root.fontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                onAccepted: {
                    console.log(text)
                    focus = false
                }

                background: Rectangle {
                    color: "#00FFFFFF"
                    border.width: 2
                    border.color: parent.activeFocus ? "#416f4c" : "lightgray"
                    Behavior on border.color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }
            }
        }
        Item {
            id: popUpEditLine2
            width: parent.width
            height: parent.height / 4
            anchors.top: popUpEditLine1.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            TextField{
                id: txtEditLine2
                width: parent.width * 0.3
                height: parent.height * 0.6
                anchors.centerIn: parent
                validator: DoubleValidator{bottom:-50; top: 10; decimals: 1;}
                inputMethodHints: Qt.ImhNoTextHandles // | Qt.ImhDigitsOnly  // | hide selection handles
                font.pixelSize: root.fontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                onAccepted: {
                    console.log(text)
                    focus = false
                }

                background: Rectangle {
                    color: "#00FFFFFF"
                    border.width: 2
                    border.color: parent.activeFocus ? "#416f4c" : "lightgray"
                    Behavior on border.color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }
            }
            Text{
                anchors.left: txtEditLine2.right
                anchors.verticalCenter: txtEditLine2.verticalCenter
                anchors.leftMargin: root.fontSize / 4
                font.pixelSize: root.fontSize
                text: "℃"
            }
        }

        Item {
            id: popUpEditLine3
            width: parent.width * 0.7
            height: parent.height / 4
            anchors.top: popUpEditLine2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btnPopUpEditModeBg
                height: root.height / 9
                width: parent.width
                anchors.centerIn: parent
                color: "lightgrey"
                radius: height / 2
            }
            Rectangle{
                id: btnPopUpEditMode
                height: root.height / 9
                width: root.width / 5
                x: popUpAddEdit.mode? popUpEditLine3.width-width :0
                anchors.verticalCenter: btnPopUpEditModeBg.verticalCenter
                color: "#3E95F9"
                radius: height / 2
                Behavior on x{
                    NumberAnimation{
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Image {
                id: imgPopUpEditMode0
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.2
                fillMode: Image.PreserveAspectFit
                source: "img/mode_0.svg"
            }
            ColorOverlay{
                anchors.fill: imgPopUpEditMode0
                source:imgPopUpEditMode0
                color:"#3E95F9"
                antialiasing: true
                opacity: popUpAddEdit.mode? 1:0
                Behavior on opacity {
                    NumberAnimation{
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Image {
                id: imgPopUpEditMode1
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.2
                fillMode: Image.PreserveAspectFit
                source: "img/mode_1.svg"
            }
            ColorOverlay{
                anchors.fill: imgPopUpEditMode1
                source:imgPopUpEditMode1
                color:"#3E95F9"
                antialiasing: true
                opacity: popUpAddEdit.mode? 0:1
                Behavior on opacity {
                    NumberAnimation{
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    popUpAddEdit.mode = !popUpAddEdit.mode
                }
            }
        }

        Item {
            id: popUpEditLine4
            width: parent.width * 0.9
            height: parent.height / 4
            anchors.top: popUpEditLine3.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: btnPopUpEditCancel
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                color: mouseAreaEditCancel.pressed? "red":"#d83324"
                radius: height / 2
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: root.fontSize
                    color: "white"
                    text: "CANCEL"
                }

                MouseArea{
                    id: mouseAreaEditCancel
                    anchors.fill: parent
                    onClicked: {
                        popUpAddEdit.visible = false
                    }
                }
            }

            Rectangle{
                id: btnPopUpEditOk
                height: root.height / 9
                width: root.width / 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                color: mouseAreaEditOk.pressed? "green":"#416f4c"
                radius: height / 2
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: root.fontSize
                    color: "white"
                    text: "OK"
                }
                MouseArea{
                    id: mouseAreaEditOk
                    anchors.fill: parent
                    onClicked: {
                        if(popUpAddEdit.isEdit) ProductsModel.set(popUpAddEdit.index, txtEditLine1.text, Number(txtEditLine2.text).toFixed(1), popUpAddEdit.mode);
                        else{
                            ProductsModel.append(txtEditLine1.text, Number(txtEditLine2.text).toFixed(1), popUpAddEdit.mode);
                            listProducts.positionViewAtEnd();
                        }
                        popUpAddEdit.visible = false
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

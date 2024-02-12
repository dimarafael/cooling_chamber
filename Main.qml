import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects

Window {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("Cooling Chamber")

    readonly property int defMargin: window.height * 0.02
    readonly property color shadowColor: "#88000000"

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
                    margins: window.defMargin
                }
                fillMode: Image.PreserveAspectFit

                source: "img/logo.png"
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

        ListModel{
            id: mocModel
            ListElement{
                name: "Element 1"
            }
            ListElement{
                name: "Element 2"
            }
            ListElement{
                name: "Element 3"
            }
            ListElement{
                name: "Element 4"
            }
            ListElement{
                name: "Element 5"
            }
            ListElement{
                name: "Element 6"
            }
            ListElement{
                name: "Element 7"
            }
            ListElement{
                name: "Element 8"
            }
            ListElement{
                name: "Element 9"
            }
            ListElement{
                name: "Element 10"
            }
            ListElement{
                name: "Element 11"
            }
            ListElement{
                name: "Element 12"
            }
        }

        Component{
            id: gridDelegate
            Item {
                id: delegateItem
                width: gridViev.cellWidth
                height: gridViev.cellHeight
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: window.defMargin / 2
                    radius: window.defMargin
                    color: "blue"
                    Text{
                        text: name
                        color: "white"
                    }
                }
            }
        }

        GridView{
            id: gridViev
            anchors{
                top: topMenu.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                // topMargin: window.defMargin / 2
                // leftMargin: window.defMargin / 2
                margins: -( window.defMargin / 2)
                topMargin: window.defMargin / 2
            }
            cellWidth: width / 4
            cellHeight: height / 3
            interactive: false

            model: mocModel
            delegate: gridDelegate

        }



    }


    // InputPanel {
    //     id: inputPanel
    //     z: 99
    //     x: 0
    //     y: window.height
    //     width: window.width

    //     states: State {
    //         name: "visible"
    //         when: inputPanel.active
    //         PropertyChanges {
    //             target: inputPanel
    //             y: window.height - inputPanel.height
    //         }
    //     }
    //     transitions: Transition {
    //         from: ""
    //         to: "visible"
    //         reversible: true
    //         ParallelAnimation {
    //             NumberAnimation {
    //                 properties: "y"
    //                 duration: 250
    //                 easing.type: Easing.InOutQuad
    //             }
    //         }
    //     }
    // }
}

import QtQuick
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import com.kometa.ProcessModel

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

        Component{
            id: gridDelegate
            Item {
                id: delegateItem
                width: gridViev.cellWidth
                height: gridViev.cellHeight

                property real lineThick: delegateItem.height * 0.005

                Rectangle{
                    id: rect1
                    anchors.fill: parent
                    anchors.margins: window.defMargin / 2
                    radius: window.defMargin
                    color: "#7F7F7F"
                    // Text{
                    //     text: productName + " " + index + " stage=" + stage
                    //     color: coolMode?"red":"white"
                    // }
                }

                DropShadow {
                    anchors.fill: rect1
                    source: rect1
                    horizontalOffset: window.defMargin / 3
                    verticalOffset: window.defMargin / 3
                    radius: 8.0
                    samples: 17
                    color: window.shadowColor
                }

                RadialGradient { // green
                    visible: stage===2
                    anchors.fill: rect1
                    source: rect1
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#61B94A" }
                        GradientStop { position: 0.5; color: "#3E9149" }
                    }
                }

                RadialGradient { // blue
                    id: gradientBlue
                    property real gradShift: 0.0
                    visible: stage===1
                    anchors.fill: rect1
                    source: rect1
                    gradient: Gradient {
                        // GradientStop { position: 0.0 + gradientBlue.gradShift; color: "#75B5FF" }
                        GradientStop { position: 0; color: "#75B5FF" }
                        GradientStop { position: 0.5; color: "#3E95F9" }
                        // GradientStop { position: 0.5 + gradientBlue.gradShift; color: "#75B5FF" }
                        // GradientStop { position: 0.75 + gradientBlue.gradShift; color: "#3E95F9" }
                    }
                }

                // PropertyAnimation{
                //     target: gradientBlue
                //     property: "gradShift"
                //     from: 0
                //     to: 1
                //     duration: 1000
                //     loops: Animation.Infinite
                //     running: true
                // }

                Item{
                    id: itemTop
                    anchors{
                        top: rect1.top
                        left: rect1.left
                        right: rect1.right
                    }
                    height: (rect1.height / 5) * 4


                }
                Rectangle{
                    id:lineHorisontalBig
                    anchors.top: itemTop.bottom
                    anchors.topMargin: -height/2
                    anchors.horizontalCenter: rect1.horizontalCenter
                    width: rect1.width * 0.95
                    height: delegateItem.lineThick
                    color: "white"
                }
                Item{
                    id: itemBotton
                    anchors{
                        bottom: rect1.bottom
                        left: rect1.left
                        right: rect1.right
                    }
                    height: rect1.height / 5
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
                margins: -( window.defMargin / 2)
                topMargin: window.defMargin / 2
            }
            cellWidth: width / 4
            cellHeight: height / 3
            interactive: false

            model: ProcessModel
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

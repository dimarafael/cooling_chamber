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
    title: qsTr("Cooling Chamber")

    readonly property int defMargin: window.height * 0.02
    readonly property color shadowColor: "#88000000"
    readonly property int fontSize1: Math.round(window.height / 30)

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

        Component{
            id: gridDelegate
            Item {
                id: delegateItem
                width: gridViev.cellWidth
                height: gridViev.cellHeight

                property real lineThick: Math.round(delegateItem.height * 0.005)

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

                    Item{
                        id: itemT4
                        anchors{
                            top: itemTop.top
                            left: itemTop.left
                        }
                        width: (rect1.width / 5) *2
                        height: rect1.height / 5
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                                rightMargin: Math.round(font.pixelSize/2)
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: temperature4.toFixed(1) + " ℃"
                        }
                    }
                    Rectangle{
                        id:lineHorisontalT4
                        anchors.top: itemT4.bottom
                        anchors.topMargin: -height/2
                        anchors.horizontalCenter: itemT4.horizontalCenter
                        width: itemT4.width * 0.89
                        height: delegateItem.lineThick
                        color: "white"
                    }

                    Item{
                        id: itemT3
                        anchors{
                            top: itemT4.bottom
                            left: itemTop.left
                        }
                        width: (rect1.width / 5) *2
                        height: rect1.height / 5
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                                rightMargin: Math.round(font.pixelSize/2)
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: temperature3.toFixed(1) + " ℃"
                        }
                    }

                    Rectangle{
                        id:lineHorisontalT3
                        anchors.top: itemT3.bottom
                        anchors.topMargin: -height/2
                        anchors.horizontalCenter: itemT3.horizontalCenter
                        width: itemT3.width * 0.89
                        height: delegateItem.lineThick
                        color: "white"
                    }

                    Item{
                        id: itemT2
                        anchors{
                            top: itemT3.bottom
                            left: itemTop.left
                        }
                        width: (rect1.width / 5) *2
                        height: rect1.height / 5
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                                rightMargin: Math.round(font.pixelSize/2)
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: temperature2.toFixed(1) + " ℃"
                        }
                    }
                    Rectangle{
                        id:lineHorisontalT2
                        anchors.top: itemT2.bottom
                        anchors.topMargin: -height/2
                        anchors.horizontalCenter: itemT2.horizontalCenter
                        width: itemT2.width * 0.89
                        height: delegateItem.lineThick
                        color: "white"
                    }

                    Item{
                        id: itemT1
                        anchors{
                            top: itemT2.bottom
                            left: itemTop.left
                        }
                        width: (rect1.width / 5) *2
                        height: rect1.height / 5
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                                rightMargin: Math.round(font.pixelSize/2)
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: temperature1.toFixed(1) + " ℃"
                        }
                    }

                    Rectangle{
                        id:lineVertical
                        // anchors.top: itemTop.top
                        anchors.left: itemT1.right
                        anchors.leftMargin: -width/2
                        anchors.verticalCenter: itemTop.verticalCenter
                        height: itemTop.height * 0.92
                        width: delegateItem.lineThick
                        color: "white"
                    }

                    Item{
                        id: itemRightTop
                        anchors{
                            top: itemTop.top
                            right: itemTop.right
                            left: itemT4.right
                            bottom: itemT3.bottom
                        }
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                                leftMargin: window.fontSize1
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: qsTr("Place")
                        }
                        Item{
                            id: itemPlaceNumber
                            anchors{
                                top: parent.top
                                right: parent.right
                                bottom: parent.bottom
                            }
                            width: height
                            Text{
                                anchors.centerIn: parent
                                font.pixelSize: window.fontSize1 * 2
                                color: "white"
                                text: (index+1)
                            }
                        }
                    }

                    Rectangle{
                        id:lineHorisontalRight
                        anchors.top: itemRightTop.bottom
                        anchors.topMargin: -height/2
                        anchors.horizontalCenter: itemRightTop.horizontalCenter
                        width: itemRightTop.width * 0.93
                        height: delegateItem.lineThick
                        color: "white"
                    }

                    Item {
                        id: itemRightBottom
                        visible: stage > 0
                        anchors{
                            right: itemTop.right
                            bottom: itemTop.bottom
                            top: itemT2.top
                            left: itemT2.right
                        }
                        Text{
                            anchors{
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                                leftMargin: Math.round(window.fontSize1/2)
                            }
                            font.pixelSize: window.fontSize1
                            color: "white"
                            text: setpoint.toFixed(1)  + "℃"
                        }
                        Item{
                            id: itemModeIcon
                            anchors{
                                top: parent.top
                                right: parent.right
                                bottom: parent.bottom
                            }
                            width: height
                            // Text{
                            //     anchors.centerIn: parent
                            //     font.pixelSize: window.fontSize1 * 2
                            //     color: "white"
                            //     text: (index+1)
                            // }
                            Image {
                                id: imgModeIcon
                                anchors.fill: parent
                                anchors.margins: height * 0.2
                                anchors.rightMargin: 0
                                fillMode: Image.PreserveAspectFit
                                source: coolMode?"img/mode_1.svg":"img/mode_0.svg"
                                // sourceSize.height: height
                                // sourceSize.width: width
                                // smooth: false
                            }
                        }

                    }

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
                    visible: stage > 0
                    anchors{
                        bottom: rect1.bottom
                        left: rect1.left
                        right: rect1.right
                    }
                    height: rect1.height / 5
                    // Text{
                    //     anchors{
                    //         top: parent.top
                    //         bottom: parent.bottom
                    //         left: parent.left
                    //         leftMargin: Math.round(window.fontSize1 / 4)
                    //     }
                    //     font.pixelSize: window.fontSize1
                    //     color: "white"
                    //     text: productName
                    // }

                    Item{
                        id: itemBottomRight
                        anchors{
                            right: parent.right
                            top: parent.top
                            bottom:parent.bottom
                        }
                        width: height * 2
                        Text {
                            anchors.fill: parent
                            font.pixelSize: window.fontSize1
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            // font.bold: true
                            color: "white"
                            text: String.fromCodePoint(0x21D2)+ " " + target
                        }
                    }
                    Item{
                        id: itemBottomLeft
                        anchors{
                            right: itemBottomRight.left
                            left: parent.left
                            top: parent.top
                            bottom:parent.bottom
                        }
                        Text{
                            anchors.fill: parent
                            font.pixelSize: window.fontSize1
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                            color: "white"
                            text: productName
                        }
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
                margins: -( window.defMargin / 2)
                topMargin: window.defMargin / 2
            }
            cellWidth: width / 4
            cellHeight: height / 3
            interactive: false
            verticalLayoutDirection: GridView.BottomToTop

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

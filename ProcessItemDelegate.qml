import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property real lineThick: Math.round(root.height * 0.005)
    property int defMargin: 5
    property color shadowColor: "#88000000"
    property int fontSize: 30

    MouseArea{
        anchors.fill: parent
        onClicked: {
            focus: true
            console.log("Delegate clicked " + (index+1).toString())
        }
    }

    Rectangle{
        id: rect1
        anchors.fill: parent
        anchors.margins: root.defMargin / 2
        radius: root.defMargin
        color: "#7F7F7F"
    }

    DropShadow {
        anchors.fill: rect1
        source: rect1
        horizontalOffset: root.defMargin / 3
        verticalOffset: root.defMargin / 3
        radius: 8.0
        samples: 17
        color: root.shadowColor
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
                font.pixelSize: root.fontSize
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
            height: root.lineThick
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
                font.pixelSize: root.fontSize
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
            height: root.lineThick
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
                font.pixelSize: root.fontSize
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
            height: root.lineThick
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
                font.pixelSize: root.fontSize
                color: "white"
                text: temperature1.toFixed(1) + " ℃"
            }
        }

        Rectangle{
            id:lineVertical
            anchors.left: itemT1.right
            anchors.leftMargin: -width/2
            anchors.verticalCenter: itemTop.verticalCenter
            height: itemTop.height * 0.92
            width: root.lineThick
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
                    leftMargin: root.fontSize
                }
                font.pixelSize: root.fontSize
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
                    font.pixelSize: root.fontSize * 2
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
            height: root.lineThick
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
                    leftMargin: Math.round(root.fontSize/2)
                }
                font.pixelSize: root.fontSize
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
        height: root.lineThick
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
                font.pixelSize: root.fontSize
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
                font.pixelSize: root.fontSize
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                color: "white"
                text: productName
            }
        }

    }

    Rectangle{
        id: rectOffline
        anchors.fill: parent
        anchors.margins: root.defMargin / 2
        radius: root.defMargin
        visible: offline
        color: "#AAFF0000"
        Image {
            id: imgOffline
            anchors.fill: parent
            anchors.margins: parent.height * 0.2
            fillMode: Image.PreserveAspectFit
            source: "img/offline.svg"
            sourceSize.height: height
        }

    }

    Image {
        id: imgBattery
        source: "img/battery"
        anchors.fill: parent
        anchors.margins: parent.height * 0.3
        fillMode: Image.PreserveAspectFit
        sourceSize.height: height
        opacity: 0

        SequentialAnimation{
            running: discharged
            loops: Animation.Infinite
            alwaysRunToEnd: true
            OpacityAnimator{
                target: imgBattery
                from: 0
                to: 1
                duration: 500
            }
            OpacityAnimator{
                target: imgBattery
                from: 1
                to: 1
                duration: 1000
            }
            OpacityAnimator{
                target: imgBattery
                from: 1
                to: 0
                duration: 500
            }
            OpacityAnimator{
                target: imgBattery
                from: 0
                to: 0
                duration: 3000
            }
        }
    }

}

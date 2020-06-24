import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Shapes 1.14
import RadialBar 1.0

import "../../Components"
import "../../Components/Buttons"
import "../../Components/FontAwesome"

Page {
    id: root
    property alias timerLabel: timerLabel
    property alias recordButton: recordButton
    property alias playButton: playButton
    property alias openButton: openButton

    property string path: ""
    property bool recorded: false
    property bool recording: false
    property alias meanDurationOfPausesValue: meanDurationOfPausesValue
    property alias speechRateValue: speechRateValue
    property alias articulationRateValue: articulationRateValue
    property alias speechRateRadialBar: speechRateRadialBar
    property alias detailsButton: detailsButton

    property double minSpeechRate: 70
    property double maxSpeechRate: 210
    property double minArticulationRate: 70
    property double maxArticulationRate: 210

    FontAwesome {
        id: awesome
    }

    Rectangle {
        id: speechRateColor
        width: speechRateTitle.height * 2
        height: speechRateTitle.height
        color: speechRateRadialBar.progressColor
        anchors.verticalCenter: speechRateTitle.verticalCenter
        anchors.right: speechRateTitle.left
        anchors.rightMargin: 5
        visible: recorded
    }

    Text {
        id: speechRateTitle
        text: qsTr("Speech Rate")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pointSize: 14
        visible: recorded
    }

    Text {
        id: speechRateValue
        text: "---"
        font.bold: true
        anchors.left: speechRateTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: speechRateTitle.verticalCenter
        font.pointSize: 14
        visible: recorded
    }

    Rectangle {
        id: articulationRateColor
        width: articulationRateTitle.height * 2
        height: articulationRateTitle.height
        color: articulationRateRadialBar.progressColor
        anchors.verticalCenter: articulationRateTitle.verticalCenter
        anchors.right: articulationRateTitle.left
        anchors.rightMargin: 5
        visible: recorded
    }

    Text {
        id: articulationRateTitle
        text: qsTr("Articulation Rate")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speechRateTitle.bottom
        anchors.topMargin: 8
        font.pointSize: 14
        visible: recorded
    }

    Text {
        id: articulationRateValue
        text: "---"
        font.bold: true
        anchors.left: articulationRateTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: articulationRateTitle.verticalCenter
        font.pointSize: 14
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesTitle
        text: qsTr("Mean Pauses")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: articulationRateTitle.bottom
        anchors.topMargin: 8
        font.pointSize: 14
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesValue
        text: "---"
        font.bold: true
        anchors.left: meanDurationOfPausesTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: meanDurationOfPausesTitle.verticalCenter
        font.pointSize: 14
        visible: recorded
    }

    Text {
        id: timerTitle
        text: qsTr("Speech Duration")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: meanDurationOfPausesTitle.bottom
        anchors.topMargin: 8
        font.pointSize: 14
        visible: recorded
    }

    Label {
        text: qsTr("Welcome to Speech Rate Meter")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 17
        font.bold: true
        anchors.bottom: timerLabel.top
        anchors.bottomMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        visible: !recorded
    }

    Text {
        id: timerLabel
        text: qsTr("00:00")
        font.bold: true
        anchors.left: timerTitle.right
        anchors.leftMargin: recorded ? 5 : -width / 2
        anchors.verticalCenter: timerTitle.verticalCenter
        font.pointSize: recorded ? 14 : 24
    }

    Image {
        id: image
        anchors.bottom: recordButton.top
        anchors.bottomMargin: 10
        anchors.top: timerLabel.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        fillMode: Image.PreserveAspectCrop
        source: "../../wave_long.svg"
        visible: !recorded
    }

    ToolButton {
        id: recordButton
        width: 150
        height: 150
        checkable: true
        font.family: awesome.solid
        text: checked ? awesome.icons.fa_stop : awesome.icons.fa_microphone
        font.pointSize: 32
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.verticalCenter: speechRateRadialBar.verticalCenter
    }

    property int plotWidth: 300 //250
    property int plotHeight: 300 //250
    property int plotDepth: 70
    property alias articulationRateRadialBar: articulationRateRadialBar

    Shape {
        id: legend
        width: plotWidth
        height: plotHeight
        layer.smooth: true
        antialiasing: true
        anchors.verticalCenter: recordButton.verticalCenter
        anchors.horizontalCenter: recordButton.horizontalCenter
        visible: recorded
        ShapePath {
            startX: 0
            startY: legend.height / 2
            fillGradient: LinearGradient {
                x1: 0
                y1: plotHeight / 2
                x2: plotWidth
                y2: plotHeight / 2
                GradientStop {
                    position: 0
                    color: "#066832"
                }
                GradientStop {
                    position: 0.5
                    color: "#c8b219"
                }
                GradientStop {
                    position: 1
                    color: "#b8181f"
                }
            }
            PathArc {
                x: legend.width
                y: legend.height / 2
                radiusX: legend.width / 2
                radiusY: legend.height / 2
                useLargeArc: false
            }
            PathLine {
                x: legend.width - plotDepth
                y: legend.height / 2
            }
            PathArc {
                x: 70
                y: legend.height / 2
                radiusX: (legend.width - plotDepth * 2) / 2
                radiusY: (legend.height - plotDepth * 2) / 2
                direction: PathArc.Counterclockwise
            }
            PathLine {
                x: 0
                y: legend.height / 2
            }
        }
    }

    RadialBar {
        id: speechRateRadialBar
        width: plotWidth + speechRateRadialBar.dialWidth
        height: plotHeight + speechRateRadialBar.dialWidth
        showText: false
        anchors.top: timerLabel.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        dialType: RadialBar.MinToMax
        progressColor: Colors.blue
        foregroundColor: "#00ffffff"
        dialWidth: 25
        startAngle: 90
        spanAngle: 180
        minValue: minSpeechRate
        maxValue: maxSpeechRate
        value: 55
        visible: recorded
    }

    RadialBar {
        id: articulationRateRadialBar
        width: plotWidth - speechRateRadialBar.dialWidth
        height: plotHeight - speechRateRadialBar.dialWidth
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.verticalCenter: speechRateRadialBar.verticalCenter
        showText: false
        dialType: RadialBar.MinToMax
        progressColor: Colors.light_green
        foregroundColor: "#00ffffff"
        dialWidth: 25
        startAngle: 90
        spanAngle: 180
        minValue: minArticulationRate
        maxValue: maxArticulationRate
        value: 55
        visible: recorded
    }

    Text {
        text: qsTr("Low")
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 4
        anchors.right: speechRateRadialBar.left
        font.pointSize: 12
        visible: recorded
    }

    Text {
        text: qsTr("Average")
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.bottom: speechRateRadialBar.top
        anchors.bottomMargin: 3
        font.pointSize: 12
        visible: recorded
    }

    Text {
        text: qsTr("Fast")
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 4
        anchors.left: speechRateRadialBar.right
        font.pointSize: 12
        visible: recorded
    }

    BottomBar {
        id: bottombar
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        content.data: [
            ShowDetailsButton {
                id: detailsButton
                width: 70
                height: 70
                visible: recorded
                font.pointSize: 20
                path: root.path
            },
            PlayButton {
                id: playButton
                width: 70
                height: 70
                visible: recorded
                font.pointSize: 20
                path: root.path
            },
            OpenFileButton {
                id: openButton
                width: 70
                height: 70
                font.pointSize: 20
                path: root.path
                visible: !recording
            }
        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


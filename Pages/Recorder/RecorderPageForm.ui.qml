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
    property alias speechRateRadialBar: speechRateRadialBar
    property alias detailsButton: detailsButton

    property double minSpeechRate: 70
    property double sec1SpeechRate: 116
    property double sec2SpeechRate: 162
    property double maxSpeechRate: 210
    property bool isLow: false
    property bool isAverage: false
    property bool isFast: false

    FontAwesome {
        id: awesome
    }

    Text {
        id: speechRateTitle
        text: qsTr("Average Speech Rate")
        anchors.horizontalCenterOffset: -width / 2 + 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        font.pointSize: 16
        visible: recorded
    }

    Text {
        id: speechRateValue
        text: "---"
        font.bold: true
        anchors.left: speechRateTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: speechRateTitle.verticalCenter
        font.pointSize: 16
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesTitle
        text: qsTr("Interphases Pauses")
        anchors.horizontalCenterOffset: -width / 2 + 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speechRateTitle.bottom
        anchors.topMargin: 10
        font.pointSize: 16
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesValue
        text: "---"
        font.bold: true
        anchors.left: meanDurationOfPausesTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: meanDurationOfPausesTitle.verticalCenter
        font.pointSize: 16
        visible: recorded
    }

    Text {
        id: timerTitle
        text: qsTr("Speech Recorded")
        anchors.horizontalCenterOffset: -width / 2 + 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: meanDurationOfPausesTitle.bottom
        anchors.topMargin: 10
        font.pointSize: 16
        visible: recorded
    }

    Text {
        id: timerLabel
        text: qsTr("00:00")
        font.bold: true
        anchors.left: timerTitle.right
        anchors.leftMargin: recorded ? 5 : -width / 2 - 20
        anchors.verticalCenter: timerTitle.verticalCenter
        font.pointSize: recorded ? 16 : 24
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

    Shape {
        id: legend
        width: 250
        height: 250
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
                y1: 125
                x2: 250
                y2: 125
                GradientStop {
                    position: 0
                    color: Colors.green
                }
                GradientStop {
                    position: 0.5
                    color: Colors.yellow
                }
                GradientStop {
                    position: 1
                    color: Colors.raspberry
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
                x: legend.width - 70
                y: legend.height / 2
            }
            PathArc {
                x: 70
                y: legend.height / 2
                radiusX: (legend.width - 140) / 2
                radiusY: (legend.height - 140) / 2
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
        width: 270
        height: 270
        showText: false
        anchors.top: timerLabel.bottom
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        dialType: RadialBar.MinToMax
        progressColor: "#3f51b5"
        foregroundColor: "#00ffffff"
        dialWidth: 25
        startAngle: 90
        spanAngle: 180
        minValue: minSpeechRate
        maxValue: maxSpeechRate
        value: 55
        visible: recorded
    }

    Text {
        text: qsTr("Low")
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 4
        anchors.right: speechRateRadialBar.left
        anchors.rightMargin: 15
        font.pointSize: isLow ? 16 : 12
        visible: recorded
        font.bold: isLow
    }

    Text {
        text: qsTr("Average")
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.bottom: speechRateRadialBar.top
        anchors.bottomMargin: 15
        font.pointSize: isAverage ? 16 : 12
        visible: recorded
        font.bold: isAverage
    }

    Text {
        text: qsTr("Fast")
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 4
        anchors.left: speechRateRadialBar.right
        anchors.leftMargin: 15
        font.pointSize: isFast ? 16 : 12
        visible: recorded
        font.bold: isFast
    }

    ShowDetailsButton {
        id: detailsButton
        width: 70
        height: 70
        visible: recorded
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: -10
        anchors.right: recordButton.left
        anchors.leftMargin: 0
        path: root.path
    }

    PlayButton {
        id: playButton
        width: 70
        height: 70
        visible: recorded
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: -10
        anchors.left: recordButton.right
        anchors.leftMargin: 0
        path: root.path
    }

    OpenFileButton {
        id: openButton
        width: 70
        height: 70
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: -10
        anchors.horizontalCenter: recordButton.horizontalCenter
        path: root.path
        visible: !recording
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


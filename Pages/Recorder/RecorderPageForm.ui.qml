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
    property alias openButton: openButton
    property alias playButton: playButton

    property string path: ""
    property bool recorded: false
    property bool recording: false
    property bool advanced: false
    property alias meanDurationOfPausesValue: meanDurationOfPausesValue
    property alias speechRateValue: speechRateValue
    property alias articulationRateValue: articulationRateValue
    property alias fillerSoundsValue: fillerSoundsValue
    property alias speechRateRadialBar: speechRateRadialBar
    property alias detailsButton: detailsButton
    property alias saveButton: saveButton

    property double minSpeechRate: 70
    property double maxSpeechRate: 210
    property double minArticulationRate: 70
    property double maxArticulationRate: 210
    property double minFillerSounds: 0
    property double maxFillerSounds: 1

    property int plotHeight: parent.height * 0.4
    property int plotWidth: plotHeight
    property int dialWidth: plotWidth * 0.12
    property int plotDepth: plotWidth * 0.25
    property int recordButtonWidth: plotWidth * 0.5
    property int recordButtonHeight: recordButtonWidth
    property alias articulationRateRadialBar: articulationRateRadialBar
    property alias meanFillerSoundsRadialBar: meanFillerSoundsRadialBar
    property alias minValue: minValue
    property alias maxValue: maxValue

    FontAwesome {
        id: awesome
    }

    Label {
        text: qsTr("Welcome to Speech Rate Meter")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 17
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: !recorded
    }

    // Speech Rate

    Text {
        id: speechRateTitle
        text: qsTr("Speech Rate")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pointSize: 18
        visible: recorded
    }

    Text {
        id: speechRateValue
        text: "---"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speechRateTitle.bottom
        anchors.topMargin: 10
        font.pointSize: 20
        font.bold: true
        visible: recorded
    }

    Rectangle {
        color: speechRateRadialBar.progressColor
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: speechRateValue.left
        anchors.rightMargin: 10
        anchors.top: speechRateValue.top
        anchors.bottom: speechRateValue.bottom
        visible: recorded
    }

    Rectangle {
        color: speechRateRadialBar.progressColor
        anchors.left: speechRateValue.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: speechRateValue.top
        anchors.bottom: speechRateValue.bottom
        visible: recorded
    }

    // Articulation Rate

    Text {
        id: articulationRateTitle
        text: qsTr("Articulation Rate")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speechRateValue.bottom
        anchors.topMargin: 10
        font.pointSize: 18
        visible: recorded
    }

    Text {
        id: articulationRateValue
        text: "---"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: articulationRateTitle.bottom
        anchors.topMargin: 10
        font.pointSize: 20
        font.bold: true
        visible: recorded
    }

    Rectangle {
        color: articulationRateRadialBar.progressColor
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: articulationRateValue.left
        anchors.rightMargin: 10
        anchors.top: articulationRateValue.top
        anchors.bottom: articulationRateValue.bottom
        visible: recorded
    }

    Rectangle {
        color: articulationRateRadialBar.progressColor
        anchors.left: articulationRateValue.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: articulationRateValue.top
        anchors.bottom: articulationRateValue.bottom
        visible: recorded
    }

    // Filler Sounds

    Text {
        id: fillerSoundsTitle
        text: qsTr("Filler Sounds")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: articulationRateValue.bottom
        anchors.topMargin: 10
        font.pointSize: 18
        visible: recorded
    }

    Text {
        id: fillerSoundsValue
        text: "---"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: fillerSoundsTitle.bottom
        anchors.topMargin: 10
        font.pointSize: 20
        font.bold: true
        visible: recorded
    }

    Rectangle {
        color: meanFillerSoundsRadialBar.progressColor
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: fillerSoundsValue.left
        anchors.rightMargin: 10
        anchors.top: fillerSoundsValue.top
        anchors.bottom: fillerSoundsValue.bottom
        visible: recorded
    }

    Rectangle {
        color: meanFillerSoundsRadialBar.progressColor
        anchors.left: fillerSoundsValue.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: fillerSoundsValue.top
        anchors.bottom: fillerSoundsValue.bottom
        visible: recorded
    }

    // Phrase Pauses

    Text {
        id: meanDurationOfPausesTitle
        text: qsTr("Phrase Pauses")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: meanDurationOfPausesValue.top
        anchors.bottomMargin: 10
        font.pointSize: 25
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesValue
        text: "---"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: timerTitle.top
        anchors.bottomMargin: 10
        font.bold: true
        font.pointSize: 30
        visible: recorded
    }

    // Speech Duration

    Text {
        id: timerTitle
        text: qsTr("Speech Duration")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: timerTitleValue.top
        anchors.bottomMargin: 10
        font.pointSize: 25
        visible: recorded
    }

    Text {
        id: timerTitleValue
        text: timerLabel.text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        font.bold: true
        font.pointSize: 30
        visible: recorded
    }

    // Timer

    Text {
        id: timerLabel
        text: qsTr("00:00")
        anchors.bottom: recordButton.top
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        font.pointSize: 24
        visible: !recorded
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

    AnimatedRecordButton {
        id: recordButton
        width: recordButtonWidth
        height: recordButtonHeight
        checkable: true
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.verticalCenter: speechRateRadialBar.verticalCenter
    }

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
                x: plotDepth
                y: legend.height / 2
                radiusX: plotDepth / 2
                radiusY: plotDepth / 2
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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: speechRateRadialBar.height / 4
        dialType: RadialBar.MinToMax
        progressColor: Colors.blue
        foregroundColor: "#00ffffff"
        dialWidth: root.dialWidth
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
        dialWidth: root.dialWidth
        startAngle: 90
        spanAngle: 180
        minValue: minArticulationRate
        maxValue: maxArticulationRate
        value: 55
        visible: recorded
    }

    RadialBar {
        id: meanFillerSoundsRadialBar
        width: plotWidth - 3 * speechRateRadialBar.dialWidth
        height: plotHeight - 3 * speechRateRadialBar.dialWidth
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.verticalCenter: speechRateRadialBar.verticalCenter
        showText: false
        dialType: RadialBar.MinToMax
        progressColor: Colors.black
        foregroundColor: "#00ffffff"
        dialWidth: root.dialWidth
        startAngle: 90
        spanAngle: 180
        minValue: minFillerSounds
        maxValue: maxFillerSounds
        value: 55
        visible: recorded
    }

    Text {
        id: minValue
        text: qsTr("--- wpm")
        font.bold: true
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 2 + 10
        anchors.left: speechRateRadialBar.left
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: maxValue
        text: qsTr("--- wpm")
        font.bold: true
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 2 + 10
        anchors.right: speechRateRadialBar.right
        font.pointSize: 12
        visible: recorded
    }

    Text {
        text: qsTr("Slow")
        font.bold: true
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 4
        anchors.right: speechRateRadialBar.left
        anchors.rightMargin: -25
        font.pointSize: 12
        visible: recorded
        transform: Rotation {
            angle: -60
        }
    }

    Text {
        text: qsTr("Average")
        font.bold: true
        anchors.horizontalCenter: speechRateRadialBar.horizontalCenter
        anchors.bottom: speechRateRadialBar.top
        anchors.bottomMargin: 3
        font.pointSize: 12
        visible: recorded
    }

    Text {
        text: qsTr("Fast")
        font.bold: true
        anchors.top: speechRateRadialBar.top
        anchors.topMargin: speechRateRadialBar.height / 6
        anchors.left: speechRateRadialBar.right
        anchors.leftMargin: -3
        font.pointSize: 12
        visible: recorded
        transform: Rotation {
            angle: 60
        }
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
                visible: recorded && advanced
                path: root.path
            },
            PlayButton {
                id: playButton
                width: 70
                height: 70
                visible: recorded
                path: root.path
            },
            OpenFileButton {
                id: openButton
                width: 70
                height: 70
                path: root.path
                visible: !recording && isOpenAvailable
            },
            SaveResultButton {
                id: saveButton
                width: 70
                height: 70
                visible: recorded && !recording
                startTime: ""
                endTime: ""
                speechRate: speechRateValue.text
                articulationRate: articulationRateValue.text
                phrasePause: meanDurationOfPausesValue.text
                speechDuration: timerLabel.text
            }

        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


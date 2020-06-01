import QtQuick 2.14
import QtQuick.Controls 2.14
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
        text: qsTr("Interphases Pause")
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

    RadialBar {
        id: speechRateRadialBar
        width: 220
        height: 220
        showText: false
        anchors.top: timerLabel.bottom
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        dialType: RadialBar.MinToMax
        progressColor: value < sec1SpeechRate ? Colors.green : value
                                                < sec2SpeechRate ? Colors.yellow : Colors.raspberry
        foregroundColor: "#2a3f51b5"
        dialWidth: 50
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
        anchors.topMargin: 0
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
        anchors.topMargin: 0
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
        anchors.topMargin: 0
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


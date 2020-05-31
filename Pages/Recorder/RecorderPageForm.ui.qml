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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    ShowDetailsButton {
        id: detailsButton
        width: 70
        height: 70
        visible: recorded
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: 20
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
        anchors.topMargin: 20
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
        anchors.topMargin: 20
        anchors.horizontalCenter: recordButton.horizontalCenter
        path: root.path
        visible: !recording
    }

    RadialBar {
        id: speechRateRadialBar
        width: 180
        height: 180
        showText: false
        anchors.verticalCenter: recordButton.verticalCenter
        anchors.horizontalCenter: recordButton.horizontalCenter
        dialType: RadialBar.MinToMax
        progressColor: value < 116 ? Colors.green : value < 162 ? Colors.yellow : Colors.raspberry
        foregroundColor: "#3F51B5"
        dialWidth: 30
        startAngle: 90
        spanAngle: 180
        minValue: 0
        maxValue: 210
        value: 55
        visible: recorded
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


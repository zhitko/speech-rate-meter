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
    property alias deleteButton: deleteButton
    property alias playButton: playButton
    property alias openButton: openButton

    property string path: ""
    property bool recorded: false
    property alias meanDurationOfPausesValue: meanDurationOfPausesValue
    property alias speechRateValue: speechRateValue
    property alias numberOfWordsValue: numberOfWordsValue
    property alias speechRateRadialBar: speechRateRadialBar

    FontAwesome {
        id: awesome
    }

    Text {
        id: timerLabel
        text: qsTr("00:00")
        anchors.bottom: recordButton.top
        anchors.bottomMargin: 30
        font.pointSize: 24
        anchors.horizontalCenter: recordButton.horizontalCenter
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

    DeleteButton {
        id: deleteButton
        width: 70
        height: 70
        visible: recorded
        toolButton.font.pointSize: 20
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
        visible: recorded
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: recordButton.horizontalCenter
        path: root.path
    }

    Text {
        id: numberOfWordsTitle
        text: qsTr("Number of Words")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        font.bold: true
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: numberOfWordsValue
        text: "---"
        anchors.left: numberOfWordsTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: numberOfWordsTitle.verticalCenter
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: speechRateTitle
        text: qsTr("Speech Rate")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: numberOfWordsTitle.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: speechRateValue
        text: "---"
        anchors.left: speechRateTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: speechRateTitle.verticalCenter
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesTitle
        text: qsTr("Mean Duration of Pauses")
        anchors.horizontalCenterOffset: -width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: speechRateTitle.bottom
        anchors.topMargin: 5
        font.bold: true
        font.pointSize: 12
        visible: recorded
    }

    Text {
        id: meanDurationOfPausesValue
        text: "---"
        anchors.left: meanDurationOfPausesTitle.right
        anchors.leftMargin: 5
        anchors.verticalCenter: meanDurationOfPausesTitle.verticalCenter
        font.pointSize: 12
        visible: recorded
    }

    RadialBar {
        id: speechRateRadialBar
        width: 200
        height: 200
        showText: false
        anchors.verticalCenter: recordButton.verticalCenter
        anchors.horizontalCenter: recordButton.horizontalCenter
        penStyle: Qt.RoundCap
        dialType: RadialBar.FullDial
        progressColor: "#1dc58f"
        foregroundColor: "#191a2f"
        dialWidth: 30
        startAngle: 180
        spanAngle: 70
        minValue: 0
        maxValue: 300
        value: 55
        suffixText: ""
        visible: recorded
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


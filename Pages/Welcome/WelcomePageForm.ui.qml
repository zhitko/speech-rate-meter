import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id: root
    width: 600
    height: 400
    title: "Home"
    property alias bStart: bStart

    Label {
        text: qsTr("Welcome to \nSpeech Rate Meter")
        anchors.bottomMargin: 10
        font.pointSize: 17
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: bStart.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: bStart
        x: 256
        y: 163
        text: qsTr("Start")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

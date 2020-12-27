import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id: root
    width: 600
    height: 400
    property alias bOpen: bOpen
    property string title: qsTr("Home")
    property alias bStart: bStart

    Label {
        text: qsTr("Welcome to \nSpeech Rate Meter")
        font.pointSize: 17
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: bStart.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: bStart
        x: 256
        y: 163
        text: qsTr("New Record")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: bOpen
        x: 256
        y: 163
        text: qsTr("Open File")
        anchors.top: bStart.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

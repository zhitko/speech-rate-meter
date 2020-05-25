import QtQuick 2.14

WelcomePageForm {
    id: page

    property var bus: ""

    bStart.onClicked: {
        bus.openRecorderPage()
    }

    anchors.fill: parent
}

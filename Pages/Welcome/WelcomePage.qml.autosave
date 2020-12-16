import QtQuick 2.14

import intondemo.backend 1.0

WelcomePageForm {
    id: page

    property var bus: ""

    Backend {
        id: backend
    }

    bStart.onClicked: {
        bus.openRecorderPage()
    }

    bOpen.onClicked: {
        let path = backend.openFileDialog()
        if (path) bus.openRecorderPage(path)
    }

    anchors.fill: parent
}

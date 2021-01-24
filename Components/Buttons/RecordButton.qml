import QtQuick 2.14

import intondemo.backend 1.0

RecordButtonForm {
    id: root

    property var bus: ""

    button.onClicked: {
        root.bus.openRecorderPage()
    }
}

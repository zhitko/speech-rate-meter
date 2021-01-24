import QtQuick 2.14

import intondemo.backend 1.0


ResultsPageForm {
    id: root

    property var bus: ""

    Backend {
        id: backend
    }

    Component.onCompleted: {
        root.results = backend.loadResult()
    }
}

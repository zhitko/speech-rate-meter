import QtQuick 2.14

import intondemo.backend 1.0

SaveResultButtonForm {
    id: root

    Backend {
        id: backend
    }

    property var startTime: ""
    property var endTime: ""
    property var speechRate: ""
    property var articulationRate: ""
    property var phrasePause: ""
    property var speechDuration: ""

    signal save()

    button.onClicked: {
        console.log("Click save results button: ")
        console.log("startTime: " + startTime)
        console.log("endTime: " + endTime)
        console.log("speechRate: " + speechRate)
        console.log("articulationRate: " + articulationRate)
        console.log("phrasePause: " + phrasePause)
        console.log("speechDuration: " + speechDuration)

        backend.saveResult(
            startTime,
            endTime,
            speechRate,
            articulationRate,
            phrasePause,
            speechDuration
        )

        root.visible = false
    }
}

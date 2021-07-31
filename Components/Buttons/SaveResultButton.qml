import QtQuick 2.14

import intondemo.backend 1.0

SaveResultButtonForm {
    id: root

    Backend {
        id: backend
    }

    property string startTime: ""
    property string endTime: ""
    property string speechRate: ""
    property string articulationRate: ""
    property string phrasePause: ""
    property string speechDuration: ""
    property string fillerSounds: ""

    signal save()

    button.onClicked: {
        console.log("Click save results button: ")
        console.log("startTime: " + startTime)
        console.log("endTime: " + endTime)
        console.log("speechRate: " + speechRate)
        console.log("articulationRate: " + articulationRate)
        console.log("phrasePause: " + phrasePause)
        console.log("speechDuration: " + speechDuration)
        console.log("fillerSounds: " + fillerSounds)

        backend.saveResult(
            startTime,
            endTime,
            speechRate,
            articulationRate,
            phrasePause,
            speechDuration,
            fillerSounds
        )

        root.visible = false
    }
}

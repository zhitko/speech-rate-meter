import QtQuick 2.14

import intondemo.backend 1.0

RecordButtonForm {
    id: root

    property var bus: ""

//    property bool recording: false
//    property Backend backend: null

//    signal record(string path)

    onClicked: {
        root.bus.openRecorderPage()
//        recording = !recording
//        console.log("Click record button: " + recording)

//        let result = backend.startStopRecordWaveFile()
//        console.log("Recording file: " + result)
//        if (!recording) root.record(result)
    }
}

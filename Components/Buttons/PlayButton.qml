import QtQuick 2.14

import intondemo.backend 1.0

PlayButtonForm {
    id: root
    property string path: ""
    property double interval: 0

    Backend {
        id: backend
    }

    button.onClicked: {
        if (path != "")
        {
            backend.playWaveFile(path, root.playing)
            root.playing = !root.playing

            let timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", root)
            timer.interval = root.interval * 1000
            timer.repeat = false
            timer.triggered.connect(function(){
                root.playing = false
            })
            timer.start()
        }
    }
}

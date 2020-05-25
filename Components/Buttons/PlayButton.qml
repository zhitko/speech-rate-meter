import QtQuick 2.14

import intondemo.backend 1.0

PlayButtonForm {
    property string path: ""

    Backend {
        id: backend
    }

    onClicked: {
        if (path != "")
            backend.playWaveFile(path)
    }
}

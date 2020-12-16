import QtQuick 2.14
import QtQuick.Controls 2.14

import intondemo.backend 1.0

DeleteButtonForm {
    property string path: ""

    signal deleted()

    Backend {
        id: backend
    }

    function showDialog(visibility) {
        dialog.visible = visibility
        toolButton.visible = !visibility
    }

    toolButton.button.onClicked: {
        if (path != "")
            showDialog(true)
    }

    okButton.onClicked: {
        backend.deleteWaveFile(path)
        showDialog(false)
        deleted()
    }

    cancelButton.onClicked: {
        showDialog(false)
    }
}

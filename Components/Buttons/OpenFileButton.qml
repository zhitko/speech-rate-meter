import QtQuick 2.14

import intondemo.backend 1.0

OpenFileButtonForm {
    id: root

    property string path: ""
    signal open(string path)

    onClicked: {
        console.log("Click open button: " + path)

        root.open(path)
    }
}

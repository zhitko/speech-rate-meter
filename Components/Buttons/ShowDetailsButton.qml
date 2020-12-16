import QtQuick 2.14

import intondemo.backend 1.0

ShowDetailsButtonForm {
    id: root

    property string path: ""
    signal open(string path)

    button.onClicked: {
        console.log("Click details button: " + path)

        root.open(path)
    }
}

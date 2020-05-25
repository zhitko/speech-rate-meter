import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../Components"
import "../../Components/Buttons"
import "../../Components/FontAwesome"

Page {
    id: root
    property alias timerLabel: timerLabel
    property alias recordButton: recordButton
    property alias deleteButton: deleteButton
    property alias playButton: playButton
    property alias openButton: openButton

    property string path: ""

    FontAwesome {
        id: awesome
    }

    Text {
        id: timerLabel
        text: qsTr("00:00")
        anchors.bottom: recordButton.top
        anchors.bottomMargin: 20
        font.pointSize: 24
        anchors.horizontalCenter: recordButton.horizontalCenter
    }

    ToolButton {
        id: recordButton
        width: 150
        height: 150
        checkable: true
        font.family: awesome.solid
        text: checked ? awesome.icons.fa_stop : awesome.icons.fa_microphone
        font.pointSize: 32
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    DeleteButton {
        id: deleteButton
        width: 70
        height: 70
        visible: false
        toolButton.font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: 20
        anchors.right: recordButton.left
        anchors.leftMargin: 0
        path: root.path
    }

    PlayButton {
        id: playButton
        width: 70
        height: 70
        visible: false
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: 20
        anchors.left: recordButton.right
        anchors.leftMargin: 0
        path: root.path
    }

    OpenFileButton {
        id: openButton
        width: 70
        height: 70
        visible: false
        font.pointSize: 20
        anchors.top: recordButton.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: recordButton.horizontalCenter
        path: root.path
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


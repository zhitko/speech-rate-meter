import QtQuick 2.14
import QtQuick.Controls 2.14
import "../FontAwesome"

Item {
    id: name
    property alias toolButton: toolButton
    property alias dialog: dialog
    width: 50
    height: 50
    property alias cancelButton: cancelButton
    property alias okButton: okButton

    Rectangle {
        id: dialog
        visible: false
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        ToolButton {
            id: cancelButton
            text: "Cancel"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
        }
        ToolButton {
            id: okButton
            text: "Ok"
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: cancelButton.left
            anchors.rightMargin: 10
        }
    }

    FontAwesomeToolButton {
        id: toolButton

        font.family: FontAwesome.regular
        text: FontAwesome.icons.faTrashAlt
        anchors.fill: parent
        property alias okButton: okButton
        property alias cancelButton: cancelButton
    }
}

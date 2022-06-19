import QtQuick 2.14

Item {
    id: root

    property string text: ""
    property string type: FontAwesome.solid
    property string icon: FontAwesome.icons.faQuestionCircle
    property string color: "white"

    FontAwesomeIcon {
        id: awesomeIcon
        type: root.type
        icon: root.icon
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: root.color
    }

    Text {
        text: root.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: awesomeIcon.right
        anchors.leftMargin: 10
        color: root.color
    }
}

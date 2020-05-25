import QtQuick 2.14

Item {
    id: root

    property string text: ""
    property string type: awesome.solid
    property string icon: awesome.icons.fa_question_circle

    FontAwesomeIcon {
        id: awesomeIcon
        type: root.type
        icon: root.icon
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Text {
        text: root.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: awesomeIcon.right
        anchors.leftMargin: 10
    }
}

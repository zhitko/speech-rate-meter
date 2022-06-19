import QtQuick 2.14

Text {
    property string type: FontAwesome.solid
    property string icon: FontAwesome.icons.faQuestionCircle
    width: 24
    height: 24

    font.family: type
    text: icon
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    font.weight: Font.Bold
    font.pointSize: 22
    anchors.verticalCenter: parent.verticalCenter
    color: "white"
}

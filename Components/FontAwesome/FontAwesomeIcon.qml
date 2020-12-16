import QtQuick 2.14

Text {
    FontAwesome {
        id: awesome
    }

    property string type: awesome.solid
    property string icon: awesome.icons.faQuestionCircle
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

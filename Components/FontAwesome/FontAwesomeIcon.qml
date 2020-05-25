import QtQuick 2.14

Text {
    FontAwesome {
        id: awesome
    }

    property string type: awesome.solid
    property string icon: awesome.icons.fa_question_circle
    width: 24
    height: 24

    font.family: type
    text: icon
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    font.weight: Font.Bold
    font.pointSize: 16
    anchors.verticalCenter: parent.verticalCenter
}

import QtQuick 2.14
import QtQuick.Controls 2.14
import "../FontAwesome"

ToolButton {
    width: 50
    height: 50
    property bool playing: false

    font.pointSize: 14

    FontAwesome {
        id: awesome
    }

    font.family: awesome.solid
    text: playing ? awesome.icons.fa_stop_circle : awesome.icons.fa_play_circle
}

import QtQuick 2.14
import QtQuick.Controls 2.14
import "../FontAwesome"

FontAwesomeToolButton {
    width: 50
    height: 50
    property bool playing: false

    font.family: awesome.solid
    text: playing ? awesome.icons.faStopCircle : awesome.icons.faPlayCircle
}

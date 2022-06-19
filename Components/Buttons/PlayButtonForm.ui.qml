import QtQuick 2.14
import QtQuick.Controls 2.14
import "../FontAwesome"

FontAwesomeToolButton {
    width: 50
    height: 50
    property bool playing: false

    font.family: FontAwesome.solid
    text: playing ? FontAwesome.icons.faStopCircle : FontAwesome.icons.faPlayCircle
}

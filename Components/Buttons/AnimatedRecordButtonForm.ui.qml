import QtQuick 2.14
import QtQuick.Controls 2.14

import "../FontAwesome"

ToolButton {
    id: recordButton
    display: AbstractButton.IconOnly
    icon.source: "qrc:/speech-icon.png"
    icon.height: 100
    icon.width: 100
    icon.color: "transparent"
}

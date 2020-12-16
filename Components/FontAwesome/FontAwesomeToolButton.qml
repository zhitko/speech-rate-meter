import QtQuick 2.14
import QtQuick.Controls 2.14

FontAwesomeIcon {
    id: root

    property alias button: button

    ToolButton {
        id: button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}

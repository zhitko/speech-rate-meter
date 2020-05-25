import QtQuick 2.4
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

ToolBar {
    id: root
    height: 55
    position: ToolBar.Footer
    property alias root: root
    rightPadding: 10
    leftPadding: 10
    bottomPadding: 3
    property alias content: content

    RowLayout {
        id: content
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

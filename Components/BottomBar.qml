import QtQuick 2.4

BottomBarForm {
    anchors.top: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right

    function adjustSpacing() {
        content.spacing = (root.width - content.width) / content.data.length
    }

    Component.onCompleted: {
        adjustSpacing()
        parent.parent.bottomPadding = height;
    }
}

import QtQuick 2.14
import QtQuick.Controls 2.14
import "../FontAwesome"

ToolButton {
    width: 50
    height: 50
    font.pointSize: 14

    FontAwesome {
        id: awesome
    }

    font.family: awesome.solid
    text: awesome.icons.fa_folder_open
}

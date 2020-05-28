import QtQuick 2.14
import QtQuick.Controls 2.14

import "Pages"
import "Pages/Welcome"
import "Pages/Settings"
import "Pages/Recorder"
import "Components"
import "Components/FontAwesome"

ApplicationWindow {
    id: appWindow
    visible: true
    minimumWidth: 640
    width: 640
    minimumHeight: 480
    height: 480
    title: qsTr("SpeechRateMeter")

    FontAwesome {
         id: awesome
    }

    StackView {
        id: stackView
        anchors.fill: parent
    }

    Bus {
        id: bus
        stackView: stackView
    }

    Component.onCompleted: {
        bus.openWelcomePage()
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: menuButton
            font.family: awesome.solid
            text: awesome.icons.fa_bars
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: drawer.open()
        }

        ToolButton {
            id: toolButton
            anchors.right: parent.right
            visible: stackView.depth > 1
            font.family: awesome.solid
            text: awesome.icons.fa_arrow_left
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: stackView.pop()
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: appWindow.width * 0.66
        height: appWindow.height

        Column {
            spacing: 10
            anchors.fill: parent

            ItemDelegate {
                id: itemDelegate
                width: parent.width
                onClicked: {
                    stackView.clear();
                    bus.openWelcomePage()
                    drawer.close()
                }

                FontAwesomeIconText {
                    icon: awesome.icons.fa_house_user
                    text: qsTr("Home")
                    anchors.fill: parent
                }
            }

            ItemDelegate {
                width: parent.width
                onClicked: {
                    bus.openSettingsPage()
                    drawer.close()
                }

                FontAwesomeIconText {
                    icon: awesome.icons.fa_sliders
                    text: qsTr("Settings")
                    anchors.fill: parent
                }
            }
        }
    }
}

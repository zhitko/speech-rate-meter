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
    minimumHeight: 800
    height: 800
    title: qsTr("SpeechRateMeter+")

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

        FontAwesomeToolButton {
            id: menuButton
            type: FontAwesome.solid
            icon: FontAwesome.icons.faBars
            anchors.left: parent.left
            anchors.leftMargin: 10
            button.onClicked: drawer.open()
        }

        FontAwesomeToolButton {
            id: toolButton
            type: FontAwesome.solid
            icon: FontAwesome.icons.faArrowLeft
            anchors.right: parent.right
            anchors.rightMargin: 10
            visible: stackView.depth > 1
            button.onClicked: stackView.pop()
        }

//        Label {
//            text: stackView.currentItem.title
//            anchors.centerIn: parent
//        }
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
                    bus.openWelcomePage()
                    drawer.close()
                }

                FontAwesomeIconText {
                    icon: FontAwesome.icons.faHouseUser
                    text: qsTr("Home")
                    anchors.fill: parent
                    color: "black"
                }
            }

            ItemDelegate {
                width: parent.width
                onClicked: {
                    bus.openResultsPage()
                    drawer.close()
                }

                FontAwesomeIconText {
                    icon: FontAwesome.icons.faHistory
                    text: qsTr("Results History")
                    anchors.fill: parent
                    color: "black"
                }
            }

            ItemDelegate {
                width: parent.width
                onClicked: {
                    bus.openSettingsPage()
                    drawer.close()
                }

                FontAwesomeIconText {
                    icon: FontAwesome.icons.faSlidersH
                    text: qsTr("Settings")
                    anchors.fill: parent
                    color: "black"
                }
            }
        }
    }
}

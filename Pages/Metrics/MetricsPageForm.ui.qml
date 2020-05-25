import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import RadialBar 1.0

import "../../Components"
import "../../Components/Buttons"

Page {
    id: root
    property string path: "Path"
    property alias recordLengthValue: recordLengthValue
    property alias consonantsAndSilenceLengthValue: consonantsAndSilenceLengthValue
    property alias consonantsAndSilenceCountValue: consonantsAndSilenceCountValue
    property alias consonantsAndSilenceMeanValue: consonantsAndSilenceMeanValue
    property alias consonantsAndSilenceMedianValue: consonantsAndSilenceMedianValue
    property alias vowelsLengthValue: vowelsLengthValue
    property alias vowelsCountValue: vowelsCountValue
    property alias vowelsMeanValue: vowelsMeanValue
    property alias vowelsMedianValue: vowelsMedianValue
    property alias vowelsRateValue: vowelsRateValue
    property alias recordButton: recordButton

    title: qsTr("Speech Rate")

    ScrollView {
        id: scrollView
        padding: 10
        contentHeight: radialbar.height + metrixBox.height
        anchors.fill: parent

        RadialBar {
            id: radialbar
            width: 300
            height: 300
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            penStyle: Qt.RoundCap
            dialType: RadialBar.FullDial
            progressColor: "#1dc58f"
            foregroundColor: "#191a2f"
            dialWidth: 30
            startAngle: 180
            spanAngle: 70
            minValue: 0
            maxValue: 100
            value: 55
            textFont {
                family: "Halvetica"
                italic: false
                pointSize: 32
            }
            suffixText: ""
            textColor: "#c61e5d"
        }

        GroupBox {
            id: metrixBox
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: radialbar.bottom
            anchors.topMargin: 10
            font.bold: true
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pointSize: 14
            title: qsTr("Details")

            ColumnLayout {
                id: columnLayout1
                anchors.fill: parent

                Text {
                    id: recordLengthTitle
                    text: qsTr("Record Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: recordLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceLengthTitle
                    text: qsTr("Consonants & Silence Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceCountTitle
                    text: qsTr("Consonants & Silence Count")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceCountValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMeanTitle
                    text: qsTr("Consonants & Silence Mean Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMeanValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMedianTitle
                    text: qsTr("Consonants & Silence Median Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMedianValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsLengthTitle
                    text: qsTr("Vowels Length")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsLengthValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsCountTitle
                    text: qsTr("Vowels Count")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsCountValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMeanTitle
                    text: qsTr("Vowels Mean Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMeanValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMedianTitle
                    text: qsTr("Vowels Median Duration")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMedianValue
                    text: "---"
                    font.pointSize: 12
                }

                Text {
                    id: vowelsRateTitle
                    text: qsTr("Vowels Speaking Rate")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsRateValue
                    text: "---"
                    font.pointSize: 12
                }
            }
        }
    }

    BottomBar {
        id: bottombar
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        content.data: [
            PlayButton {
                id: playButton
                path: root.path
            },
            RecordButton {
                id: recordButton
            }
        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


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
    property alias consonantsAndSilenceMaxValue: consonantsAndSilenceMaxValue
    property alias vowelsMaxValue: vowelsMaxValue
    property alias meanFillerSoundsValue: meanFillerSoundsValue
    property alias playButton: playButton

    title: qsTr("Details")

    ScrollView {
        id: scrollView
        padding: 10
        contentHeight: metrixBox.height
        anchors.fill: parent

        GroupBox {
            id: metrixBox
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
                    id: consonantsAndSilenceMaxTitle
                    text: qsTr("Consonants & Silence Max")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: consonantsAndSilenceMaxValue
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
                    id: vowelsMaxTitle
                    text: qsTr("Vowels Max")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: vowelsMaxValue
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

                Text {
                    id: meanFillerSoundsTitle
                    text: qsTr("Mean Filler Sounds")
                    font.bold: true
                    font.pointSize: 12
                }

                Text {
                    id: meanFillerSoundsValue
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
                width: 70
                height: 70
            }
        ]
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


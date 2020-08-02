import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import "../../Components"

Page {
    id: page
    property alias intensityFrameValue: intensityFrameValue
    property alias intensitySmoothFrameValue: intensitySmoothFrameValue
    property alias intensityShiftValue: intensityShiftValue
    property alias intensityMaxLengthValue: intensityMaxLengthValue
    property alias kSpeechRateValue: kSpeechRateValue
    property alias minSpeechRateValue: minSpeechRateValue
    property alias maxSpeechRateValue: maxSpeechRateValue
    property alias kArticulationRateValue: kArticulationRateValue
    property alias kMeanPausesValue: kMeanPausesValue
    title: qsTr("Settings")

    ScrollView {
        id: scrollView
        contentWidth: parent.width
        clip: true
        anchors.fill: parent
        ScrollBar.vertical.interactive: true

        ColumnLayout {
            id: columnLayout1
            anchors.fill: parent
            spacing: 10

            GroupBox {
                id: spechRateGroup
                Layout.margins: 10
                Layout.fillWidth: true
                font.pointSize: 14
                title: qsTr("Speech Rate")

                ColumnLayout {
                    anchors.fill: parent

                    Text {
                        id: kSpeechRateTitle
                        text: qsTr("K1")
                        font.pointSize: 12
                        visible: advanced.checked
                    }

                    DoubleSpinBox {
                        id: kSpeechRateValue
                        decimals: 2
                        to: 99999
                        wheelEnabled: true
                        editable: true
                        stepSize: 100
                        visible: advanced.checked
                    }

                    Text {
                        id: minSpeechRateTitle
                        text: qsTr("Min RS")
                        font.pointSize: 12
                    }

                    DoubleSpinBox {
                        id: minSpeechRateValue
                        decimals: 2
                        to: 99999
                        wheelEnabled: true
                        editable: true
                        stepSize: 10
                    }

                    Text {
                        id: maxSpeechRateTitle
                        text: qsTr("Max RS")
                        font.pointSize: 12
                    }

                    DoubleSpinBox {
                        id: maxSpeechRateValue
                        decimals: 2
                        to: 99999
                        wheelEnabled: true
                        editable: true
                        stepSize: 10
                    }
                }
            }

            GroupBox {
                id: articulationRateGroup
                Layout.margins: 10
                Layout.fillWidth: true
                font.pointSize: 14
                title: qsTr("Articulation Rate")
                visible: advanced.checked

                ColumnLayout {
                    anchors.fill: parent

                    Text {
                        id: kArticulationRateTitle
                        text: qsTr("K2")
                        font.pointSize: 12
                    }

                    DoubleSpinBox {
                        id: kArticulationRateValue
                        decimals: 2
                        to: 99999
                        wheelEnabled: true
                        editable: true
                        stepSize: 100
                    }
                }
            }

            GroupBox {
                id: meanPausesGroup
                Layout.margins: 10
                Layout.fillWidth: true
                font.pointSize: 14
                title: qsTr("Phrase Pauses")
                visible: advanced.checked

                ColumnLayout {
                    anchors.fill: parent

                    Text {
                        id: kMeanPausesTitle
                        text: qsTr("K3")
                        font.pointSize: 12
                    }

                    DoubleSpinBox {
                        id: kMeanPausesValue
                        decimals: 2
                        to: 99999
                        wheelEnabled: true
                        editable: true
                        stepSize: 100
                    }
                }
            }

            GroupBox {
                id: intensityGroup
                Layout.margins: 10
                Layout.fillWidth: true
                font.pointSize: 14
                title: qsTr("Intensity")
                visible: advanced.checked

                ColumnLayout {
                    anchors.fill: parent

                    Text {
                        id: intensityFrameTitle
                        text: qsTr("Frame")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityFrameValue
                        to: 1024
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensityShiftTitle
                        text: qsTr("Shift")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityShiftValue
                        to: 512
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensitySmoothFrameTitle
                        text: qsTr("Smooth Frame")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensitySmoothFrameValue
                        to: 1024
                        wheelEnabled: true
                        editable: true
                    }

                    Text {
                        id: intensityMaxLengthTitle
                        text: qsTr("Segment length limit (millisec)")
                        font.pointSize: 12
                    }

                    SpinBox {
                        id: intensityMaxLengthValue
                        to: 2000
                        wheelEnabled: true
                        editable: true
                    }
                }
            }
        }
    }

    CheckBox {
        id: advanced
        text: qsTr("Advanced")
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


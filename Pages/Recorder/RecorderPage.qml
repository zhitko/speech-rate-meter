import QtQuick 2.14

import intondemo.backend 1.0

import "../../Components/FontAwesome"


RecorderPageForm {
    id: root

    property var bus: ""

    property int sec: 0
    property int min: 0

    Backend {
        id: backend
    }

    FontAwesome {
        id: awesome
    }

    function setControlsVisible(visible)
    {
        recorded = visible
    }

    function setTimerLabel()
    {
        timerLabel.text = qsTr("%1:%2 sec")
            .arg(root.min.toString().padStart(2, '0'))
            .arg(root.sec.toString().padStart(2, '0'))
    }

    function resetTimer()
    {
        root.sec = 0
        root.min = 0
        setTimerLabel()
    }

    function startTimer()
    {
        setControlsVisible(false)
        resetTimer()
        timer.restart()
    }

    function stopTimer()
    {
        setControlsVisible(true)
        timer.stop()
    }

    function addMin()
    {
        root.min++
    }

    function addSec()
    {
        root.sec++
        if (root.sec == 60)
        {
            root.sec = 0
            addMin()
        }
    }

    Timer {
        id: timer
        interval: 1000;
        running: false;
        repeat: true
        onTriggered: {
            addSec()
            setTimerLabel()
        }
    }

    recordButton.onClicked: {
        if (recordButton.checked)
        {
            startTimer()
            root.path = backend.startStopRecordWaveFile()
        } else {
            stopTimer()
            root.path = backend.startStopRecordWaveFile()
            showSpeechRate()
        }
    }

    deleteButton.onDeleted: {
        setControlsVisible(false)
        resetTimer()
    }

    openButton.onOpen: {
        bus.openMetricsPage(path)
    }

    Component.onCompleted: {

    }

    function showSpeechRate() {
        let back = Qt.createQmlObject('import intondemo.backend 1.0; Backend{}', root)
        let startPoint = 0
        let endPoint = 1
        let numberOfWords = back.getNumberOfWords(root.path, startPoint, endPoint)
        numberOfWordsValue.text = qsTr("%1 words").arg(String(numberOfWords.toFixed(0)))
        let speechRate = back.getSpeechRate(root.path, startPoint, endPoint)
        speechRateValue.text = qsTr("%1 wpm").arg(String(speechRate.toFixed(3)))
        let meanDurationOfPauses = back.getMeanDurationOfPauses(root.path, startPoint, endPoint)
        meanDurationOfPausesValue.text = qsTr("%1 sec").arg(String(meanDurationOfPauses.toFixed(3)))

        speechRateRadialBar.value = speechRate
    }
}

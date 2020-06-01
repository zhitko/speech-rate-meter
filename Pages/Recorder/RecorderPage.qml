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
        timerLabel.text = qsTr("%1:%2")
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
        root.recording = true;
    }

    function stopTimer()
    {
        setControlsVisible(true)
        timer.stop()
        root.recording = false;
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

    openButton.onOpen: {
        let path = backend.openFileDialog()
        if (path) {
            root.path = path
            setControlsVisible(true)
            showSpeechRate()
        }
    }

    detailsButton.onOpen: {
        bus.openMetricsPage(path)
    }

    Component.onCompleted: {
        if (path) {
            setControlsVisible(true)
            showSpeechRate()
        }

        root.minSpeechRate = backend.getMinSpeechRate()
        root.maxSpeechRate = backend.getMaxSpeechRate()
        let secSize = (root.maxSpeechRate - root.minSpeechRate) / 3
        root.sec1SpeechRate = root.minSpeechRate + secSize
        root.sec2SpeechRate = root.sec1SpeechRate + secSize
        console.log("minSpeechRate: " + minSpeechRate)
        console.log("sec1SpeechRate: " + sec1SpeechRate)
        console.log("sec2SpeechRate: " + sec2SpeechRate)
        console.log("maxSpeechRate: " + maxSpeechRate)
    }

    function showSpeechRate() {
        let back = Qt.createQmlObject('import intondemo.backend 1.0; Backend{}', root)
        let startPoint = 0
        let endPoint = 1
        let speechRate = back.getSpeechRate(root.path, startPoint, endPoint)
        speechRateValue.text = qsTr("%1 wpm").arg(String(speechRate.toFixed(3)))
        let meanDurationOfPauses = back.getMeanDurationOfPauses(root.path, startPoint, endPoint)
        meanDurationOfPausesValue.text = qsTr("%1 sec").arg(String(meanDurationOfPauses.toFixed(3)))

        let waveLength = back.getWaveLength(root.path, startPoint, endPoint)
        timerLabel.text = qsTr("%1 sec").arg(waveLength)

        root.isLow = false
        root.isAverage = false
        root.isFast = false

        if (speechRate > root.maxSpeechRate) speechRate = root.maxSpeechRate
        if (speechRate < root.minSpeechRate) speechRate = root.minSpeechRate

        if (speechRate > root.sec2SpeechRate) isFast = true
        else if (speechRate > root.sec1SpeechRate) isAverage = true
        else isLow = true

        speechRateRadialBar.value = speechRate
    }
}

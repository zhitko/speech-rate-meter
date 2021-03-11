import QtQuick 2.14

import intondemo.backend 1.0
import intondemo.settings 1.0

import "../../Components/FontAwesome"


RecorderPageForm {
    id: root

    property var bus: ""
    property bool autostart: false

    property int sec: 0
    property int min: 0

    Backend {
        id: backend
    }

    Settings {
        id: settings
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
        recordButton.checked = true
        setControlsVisible(false)
        resetTimer()
        timer.restart()
        root.recording = true;
    }

    function stopTimer()
    {
        recordButton.checked = false
        setControlsVisible(true)
        timer.stop()
        root.recording = false
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

    function delay(delayTime, cb, repeat = false, max = 1)
    {
        let tryCount = 0
        let timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", root)
        timer.triggeredOnStart = true
        timer.interval = delayTime
        timer.repeat = repeat
        timer.triggered.connect(function(){
            console.log("delay: tryCount " + tryCount)
            let result = cb()
            console.log("delay: result " + result)
            tryCount++
            if (result || tryCount > max) {
                console.log("delay: Stop trying")
                timer.stop()
            }
        })
        timer.start()
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
        console.log("RecorderPage: recordButton.onClicked")
        var today = new Date()
        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate()
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds()
        var dateTime = date+' '+time

        if (root.recording)
        {
            console.log("RecorderPage: stop recording")
            saveButton.endTime = time
            recordButton.checked = true
            saveButton.visible = true

            stopTimer()
            backend.startStopRecordWaveFile()
            showSpeechRate()
        } else {
            console.log("RecorderPage: start new recording")
            saveButton.startTime = dateTime
            recordButton.checked = false

            startTimer()
            root.path = backend.startStopRecordWaveFile()
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
        let isFilePresent = !!root.path
        let startRecording = root.autostart && !isFilePresent

        if (startRecording) {
            console.log("Component.onCompleted: Autostart recording")
            startTimer()
            backend.startStopRecordWaveFile()
        } else if (isFilePresent) {
            console.log("Component.onCompleted: Show results")
            setControlsVisible(true)
            showSpeechRate()
        } else {
            console.log("Component.onCompleted: Waiting for start")
        }
    }

    function showSpeechRate() {
        let stngs = settings.getInstance();
        console.log("showSpeechRate: " + stngs)

        root.minSpeechRate = stngs.getMinSpeechRate()
        root.maxSpeechRate = stngs.getMaxSpeechRate()

        root.minValue.text = qsTr("%1 wpm").arg(String(root.minSpeechRate.toFixed(0)))
        root.maxValue.text = qsTr("%1 wpm").arg(String(root.maxSpeechRate.toFixed(0)))

        root.minArticulationRate = stngs.getMinArticulationRate()
        root.maxArticulationRate = stngs.getMaxArticulationRate()

        advanced = stngs.getAdvanced()

        calculateSpeechRate()
    }

    function calculateSpeechRate() {
        console.log("calculateSpeechRate")
        let startPoint = 0
        let endPoint = 1

        let waveLength = backend.getWaveLength(root.path, startPoint, endPoint)
        console.log("calculateSpeechRate: waveLength " + waveLength)
        if (!waveLength) return false
        timerLabel.text = qsTr("%1 sec").arg(String(waveLength.toFixed(0)))

        playButton.interval = waveLength

        let speechRate = backend.getSpeechRate(root.path, startPoint, endPoint)
        console.log("calculateSpeechRate: speechRate " + speechRate)
        speechRateValue.text = qsTr("%1 wpm").arg(String(speechRate.toFixed(0)))

        if (speechRate > root.maxSpeechRate) speechRate = root.maxSpeechRate
        if (speechRate < root.minSpeechRate) speechRate = root.minSpeechRate

        speechRateRadialBar.value = speechRate

        let meanDurationOfPauses = backend.getMeanDurationOfPauses(root.path, startPoint, endPoint)
        console.log("calculateSpeechRate: meanDurationOfPauses " + meanDurationOfPauses)
        meanDurationOfPausesValue.text = qsTr("%1 sec").arg(String(meanDurationOfPauses.toFixed(2)))

        let articulationRate =  backend.getArticulationRate(root.path, startPoint, endPoint)
        console.log("calculateSpeechRate: articulationRate " + articulationRate)
        articulationRateValue.text = qsTr("%1 wpm").arg(String(articulationRate.toFixed(0)))

        if (articulationRate > root.maxArticulationRate) articulationRate = root.maxArticulationRate
        if (articulationRate < root.minArticulationRate) articulationRate = root.minArticulationRate

        articulationRateRadialBar.value = articulationRate

        return true
    }
}

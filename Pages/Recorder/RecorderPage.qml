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
        playButton.visible = visible
        deleteButton.visible = visible
        openButton.visible = visible
    }

    function setTimerLabel()
    {
        timerLabel.text = "%1:%2"
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
}

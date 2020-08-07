import QtQuick 2.4

AnimatedRecordButtonForm {
    id: root

    property int frame: 0

    Timer {
        id: timer
        interval: 500;
        repeat: true
        onTriggered: {
            root.icon.source = "qrc:/speech-active-%1-icon.png".arg(frame)
            frame ++
            if (frame > 3) frame = 0
        }
    }

    onCheckedChanged: {
        if (checked)
        {
            timer.start()
            root.icon.source = "qrc:/speech-active-0-icon.png"
        } else {
            timer.stop()
            root.icon.source = "qrc:/speech-icon.png"
        }
    }
}

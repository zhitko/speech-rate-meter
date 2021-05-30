import QtQuick 2.14

import intondemo.backend 1.0
import intondemo.settings 1.0

SettingsPageForm {
    id: root

    property bool loading: true

    anchors.fill: parent

    Backend {
        id: backend
    }

    Settings {
        id: settings
    }

    Component.onCompleted: {
        root.loading = true
        let stngs = settings.getInstance()

        intensityFrameValue.value = stngs.getIntensityFrame()
        intensityShiftValue.value = stngs.getIntensityShift()
        intensitySmoothFrameValue.value = stngs.getIntensitySmoothFrame()
        intensityMaxLengthValue.value = stngs.getIntensityMaxLengthValue()

        kSpeechRateValue.value = stngs.getKSpeechRate() * 100
        minSpeechRateValue.value = stngs.getMinSpeechRate() * 100
        maxSpeechRateValue.value = stngs.getMaxSpeechRate() * 100
        kArticulationRateValue.value = stngs.getKArticulationRate() * 100
        kMeanPausesValue.value = stngs.getKMeanPauses() * 100
        kFillerSoundsValue.value = stngs.getKFillerSounds() * 100
        minFillerSoundsValue.value = stngs.getMinFillerSounds() * 100
        maxFillerSoundsValue.value = stngs.getMaxFillerSounds() * 100

        advanced.checked = stngs.getAdvanced()
        root.loading = false
    }

    advanced.onCheckedChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setAdvanced(advanced.checked)
    }

    intensityFrameValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setIntensityFrame(intensityFrameValue.value)
    }

    intensityShiftValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setIntensityShift(intensityShiftValue.value)
    }

    intensitySmoothFrameValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setIntensitySmoothFrame(intensitySmoothFrameValue.value)
    }

    intensityMaxLengthValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setIntensityMaxLengthValue(intensityMaxLengthValue.value)
    }

    kSpeechRateValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setKSpeechRate(kSpeechRateValue.value / 100)
    }

    minSpeechRateValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setMinSpeechRate(minSpeechRateValue.value / 100)
        stngs.setMinArticulationRate(minSpeechRateValue.value / 100)
    }

    maxSpeechRateValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setMaxSpeechRate(maxSpeechRateValue.value / 100)
        stngs.setMaxArticulationRate(maxSpeechRateValue.value / 100)
    }

    kArticulationRateValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setKArticulationRate(kArticulationRateValue.value / 100)
    }

    kMeanPausesValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setKMeanPauses(kMeanPausesValue.value / 100)
    }

    kFillerSoundsValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setKFillerSounds(kFillerSoundsValue.value / 100)
    }

    minFillerSoundsValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setMinFillerSounds(minFillerSoundsValue.value / 100)
    }

    maxFillerSoundsValue.onValueChanged: {
        if (root.loading) return
        let stngs = settings.getInstance()
        stngs.setMaxFillerSounds(maxFillerSoundsValue.value / 100)
    }

}

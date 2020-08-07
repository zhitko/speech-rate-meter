import QtQuick 2.14

import intondemo.backend 1.0

SettingsPageForm {
    anchors.fill: parent

    Backend {
        id: backend
    }

    Component.onCompleted: {
        intensityFrameValue.value = backend.getIntensityFrame();
        intensityShiftValue.value = backend.getIntensityShift();
        intensitySmoothFrameValue.value = backend.getIntensitySmoothFrame();
        intensityMaxLengthValue.value = backend.getIntensityMaxLengthValue();

        kSpeechRateValue.value = backend.getKSpeechRate() * 100;
        minSpeechRateValue.value = backend.getMinSpeechRate() * 100;
        maxSpeechRateValue.value = backend.getMaxSpeechRate() * 100;
        kArticulationRateValue.value = backend.getKArticulationRate() * 100;
        kMeanPausesValue.value = backend.getKMeanPauses() * 100;

        advanced.checked = backend.getAdvanced()
    }

    advanced.onCheckedChanged: {
        backend.setAdvanced(advanced.checked)
    }

    intensityFrameValue.onValueChanged: {
        backend.setIntensityFrame(intensityFrameValue.value);
    }

    intensityShiftValue.onValueChanged: {
        backend.setIntensityShift(intensityShiftValue.value);
    }

    intensitySmoothFrameValue.onValueChanged: {
        backend.setIntensitySmoothFrame(intensitySmoothFrameValue.value);
    }

    intensityMaxLengthValue.onValueChanged: {
        backend.setIntensityMaxLengthValue(intensityMaxLengthValue.value);
    }

    kSpeechRateValue.onValueChanged: {
        backend.setKSpeechRate(kSpeechRateValue.value / 100);
    }

    minSpeechRateValue.onValueChanged: {
        backend.setMinSpeechRate(minSpeechRateValue.value / 100);
        backend.setMinArticulationRate(minSpeechRateValue.value / 100);
    }

    maxSpeechRateValue.onValueChanged: {
        backend.setMaxSpeechRate(maxSpeechRateValue.value / 100);
        backend.setMaxArticulationRate(maxSpeechRateValue.value / 100);
    }

    kArticulationRateValue.onValueChanged: {
        backend.setKArticulationRate(kArticulationRateValue.value / 100);
    }

    kMeanPausesValue.onValueChanged: {
        backend.setKMeanPauses(kMeanPausesValue.value / 100);
    }

}

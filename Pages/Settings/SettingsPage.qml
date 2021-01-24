import QtQuick 2.14

import intondemo.backend 1.0
import intondemo.settings 1.0

SettingsPageForm {
    anchors.fill: parent

    Backend {
        id: backend
    }

    Settings {
        id: settings
    }

    Component.onCompleted: {
        let stngs = settings.getInstance();

        intensityFrameValue.value = stngs.getIntensityFrame();
        intensityShiftValue.value = stngs.getIntensityShift();
        intensitySmoothFrameValue.value = stngs.getIntensitySmoothFrame();
        intensityMaxLengthValue.value = stngs.getIntensityMaxLengthValue();

        kSpeechRateValue.value = stngs.getKSpeechRate() * 100;
        minSpeechRateValue.value = stngs.getMinSpeechRate() * 100;
        maxSpeechRateValue.value = stngs.getMaxSpeechRate() * 100;
        kArticulationRateValue.value = stngs.getKArticulationRate() * 100;
        kMeanPausesValue.value = stngs.getKMeanPauses() * 100;

        advanced.checked = stngs.getAdvanced()
    }

    advanced.onCheckedChanged: {
        let stngs = settings.getInstance();
        stngs.setAdvanced(advanced.checked)
    }

    intensityFrameValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setIntensityFrame(intensityFrameValue.value);
    }

    intensityShiftValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setIntensityShift(intensityShiftValue.value);
    }

    intensitySmoothFrameValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setIntensitySmoothFrame(intensitySmoothFrameValue.value);
    }

    intensityMaxLengthValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setIntensityMaxLengthValue(intensityMaxLengthValue.value);
    }

    kSpeechRateValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setKSpeechRate(kSpeechRateValue.value / 100);
    }

    minSpeechRateValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setMinSpeechRate(minSpeechRateValue.value / 100);
        stngs.setMinArticulationRate(minSpeechRateValue.value / 100);
    }

    maxSpeechRateValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setMaxSpeechRate(maxSpeechRateValue.value / 100);
        stngs.setMaxArticulationRate(maxSpeechRateValue.value / 100);
    }

    kArticulationRateValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setKArticulationRate(kArticulationRateValue.value / 100);
    }

    kMeanPausesValue.onValueChanged: {
        let stngs = settings.getInstance();
        stngs.setKMeanPauses(kMeanPausesValue.value / 100);
    }

}

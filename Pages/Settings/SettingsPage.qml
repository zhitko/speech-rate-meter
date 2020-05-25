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
        kCoeficient.value = backend.getKCoeficient() * 100;
        mCoeficient.value = backend.getMCoeficient() * 100;
    }

    intensityMaxLengthValue.onValueChanged: {
        backend.setIntensityMaxLengthValue(intensityMaxLengthValue.value);
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

    kCoeficient.onValueChanged: {
        backend.setKCoeficient(kCoeficient.value / 100);
    }

    mCoeficient.onValueChanged: {
        backend.setMCoeficient(mCoeficient.value / 100);
    }
}

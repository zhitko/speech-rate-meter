import QtQuick 2.14

import intondemo.backend 1.0


MetricsPageForm {
    id: root

    property var bus: ""

    Backend {
        id: backend
    }

    Component.onCompleted: {
        loadMetrics()

        recordButton.bus = bus
    }

    function loadMetrics() {
        let startPoint = 0
        let endPoint = 1

        let waveLength = backend.getWaveLength(root.path, startPoint, endPoint);
        recordLengthValue.text = String(waveLength.toFixed(2))

        let vowelsCount = backend.getVowelsCount(root.path, startPoint, endPoint)
        vowelsCountValue.text = String(vowelsCount)

        let vowelsRate = backend.getVowelsRate(root.path, startPoint, endPoint)
        vowelsRateValue.text = String(vowelsRate.toFixed(2))

        let vowelsLength = backend.getVowelsLength(root.path, startPoint, endPoint)
        vowelsLengthValue.text = String(vowelsLength.toFixed(2))

        let consonantsAndSilenceLength = backend.getConsonantsAndSilenceLength(root.path, startPoint, endPoint)
        consonantsAndSilenceLengthValue.text = String(consonantsAndSilenceLength.toFixed(2))

        let consonantsAndSilenceCount = backend.getConsonantsAndSilenceCount(root.path, startPoint, endPoint)
        consonantsAndSilenceCountValue.text = String(consonantsAndSilenceCount)

        let vowelsMean = backend.getVowelsSquareMeanValue(root.path, startPoint, endPoint)
        vowelsMeanValue.text = String(vowelsMean.toFixed(2))

        let consonantsAndSilenceMean = backend.getConsonantsAndSilenceMeanSquareValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMeanValue.text = String(consonantsAndSilenceMean.toFixed(2))

        let consonantsAndSilenceMedian = backend.getConsonantsAndSilenceMedianValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMedianValue.text = String(consonantsAndSilenceMedian)

        let vowelsMedianMedian = backend.getVowelsMedianValue(root.path, startPoint, endPoint)
        vowelsMedianValue.text = String(vowelsMedianMedian)

        let vowelsMax = backend.getVowelsMax(root.path, startPoint, endPoint)
        vowelsMaxValue.text = String(vowelsMax.toFixed(2))

        let consonantsAndSilenceMax = backend.getConsonantsAndSilenceMax(root.path, startPoint, endPoint)
        consonantsAndSilenceMaxValue.text = String(consonantsAndSilenceMax.toFixed(2))

        let meanFillerSounds = backend.getMeanFillerSounds(root.path, startPoint, endPoint)
        meanFillerSoundsValue.text = String(meanFillerSounds.toFixed(2))
    }
}

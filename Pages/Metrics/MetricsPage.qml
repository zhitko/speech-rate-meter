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

        let vowelsMean = backend.getVowelsMeanValue(root.path, startPoint, endPoint)
        vowelsMeanValue.text = String(vowelsMean.toFixed(2))

        let consonantsAndSilenceMean = backend.getConsonantsAndSilenceMeanValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMeanValue.text = String(consonantsAndSilenceMean.toFixed(2))

        let consonantsAndSilenceMedian = backend.getConsonantsAndSilenceMedianValue(root.path, startPoint, endPoint)
        consonantsAndSilenceMedianValue.text = String(consonantsAndSilenceMedian)

        let vowelsMedianMedian = backend.getVowelsMedianValue(root.path, startPoint, endPoint)
        vowelsMedianValue.text = String(vowelsMedianMedian)

        let vowelsMax = backend.getVowelsMax(root.path, startPoint, endPoint)
        vowelsMaxValue.text = String(vowelsMax.toFixed(2))

        let consonantsAndSilenceMax = backend.getConsonantsAndSilenceMax(root.path, startPoint, endPoint)
        consonantsAndSilenceMaxValue.text = String(consonantsAndSilenceMax.toFixed(2))

        let consonantsAndSilenceVariance = backend.getConsonantsAndSilenceVarianceValue(root.path, startPoint, endPoint)
        consonantsAndSilenceVarianceValue.text = String(consonantsAndSilenceVariance.toFixed(2))
        let consonantsAndSilenceSkewness = backend.getConsonantsAndSilenceSkewnessValue(root.path, startPoint, endPoint)
        consonantsAndSilenceSkewnessValue.text = String(consonantsAndSilenceSkewness.toFixed(2))
        let consonantsAndSilenceKurtosis = backend.getConsonantsAndSilenceKurtosisValue(root.path, startPoint, endPoint)
        consonantsAndSilenceKurtosisValue.text = String(consonantsAndSilenceKurtosis.toFixed(2))

        let vowelsVariance = backend.getVowelsVarianceValue(root.path, startPoint, endPoint)
        vowelsVarianceValue.text = String(vowelsVariance.toFixed(2))
        let vowelsSkewness = backend.getVowelsSkewnessValue(root.path, startPoint, endPoint)
        vowelsSkewnessValue.text = String(vowelsSkewness.toFixed(2))
        let vowelsKurtosis = backend.getVowelsKurtosisValue(root.path, startPoint, endPoint)
        vowelsKurtosisValue.text = String(vowelsKurtosis.toFixed(2))
    }
}

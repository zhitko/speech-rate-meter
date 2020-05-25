import QtQuick 2.14
import QtQuick.Controls 2.14

SpinBox {
    id: spinbox
    stepSize: 100

    property int decimals: 2
    property real realValue: value / Math.pow(10,decimals)

    validator: DoubleValidator {
        bottom: Math.min(spinbox.from, spinbox.to)
        top:  Math.max(spinbox.from, spinbox.to)
    }

    textFromValue: function(value, locale) {
        return Number(value / Math.pow(10,decimals)).toLocaleString(locale, 'f', spinbox.decimals)
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text) * Math.pow(10,decimals)
    }
}

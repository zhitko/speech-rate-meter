pragma Singleton
import QtQuick 2.14

QtObject {
    readonly property string black: "#000000"
    readonly property string teal_blue: "#006E82"
    readonly property string purple: "#8214A0"
    readonly property string blue: "#005AC8"
    readonly property string azure: "#00A0FA"
    readonly property string pink: "#FA78FA"
    readonly property string aqua: "#14D2DC"
    readonly property string raspberry: "#AA0A3C"
    readonly property string green: "#0A9B4B"
    readonly property string varmillion: "#FF825F"
    readonly property string yellow: "#EAD644"
    readonly property string light_green: "#A0FA82"
    readonly property string banana_mania: "#FAE6BE"

    function setAlpha(color, alpha) {
        return color.replace("#", "#"+alpha);
    }
}

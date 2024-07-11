pragma Singleton
import QtQuick 2.14

Item {
    id: awesome

    property alias icons: variables

    readonly property FontLoader fontAwesomeRegular: FontLoader {
        source: "/3party/FontAwesome/Font Awesome 5 Free-Regular-400.ttf"
    }
    readonly property FontLoader fontAwesomeSolid: FontLoader {
        source: "/3party/FontAwesome/Font Awesome 5 Free-Solid-900.ttf"
    }
    readonly property FontLoader fontAwesomeBrands: FontLoader {
        source: "/3party/FontAwesome/Font Awesome 5 Brands-Regular-400.ttf"
    }

    readonly property string regular: fontAwesomeRegular.name
    readonly property string solid: fontAwesomeSolid.name
    readonly property string brands: fontAwesomeBrands.name

    FontAwesomeVariables {
        id: variables
    }
}

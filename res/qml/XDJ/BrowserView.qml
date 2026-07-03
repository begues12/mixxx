import ".." as Skin
import QtQuick 2.12
import "../Theme"

// Modo Browser: reutiliza la biblioteca QML de Mixxx (incluye la
// fuente Rekordbox para USB exportados) a pantalla completa.
Item {
    id: root

    Skin.Library {
        anchors.fill: parent
    }
}

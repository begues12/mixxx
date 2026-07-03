import ".." as Skin
import QtQuick 2.12
import QtQuick.Controls
import "../Theme"

// Modo Settings: reutiliza el panel de ajustes QML (audio,
// latencia, controladoras) embebido a pantalla completa en lugar
// de un diálogo modal de escritorio.
Rectangle {
    id: root

    color: Theme.backgroundColor

    Skin.Settings {
        id: settings

        closePolicy: Popup.NoAutoClose
        height: parent.height
        modal: false
        visible: root.visible
        width: parent.width
        x: 0
        y: 0
    }
}

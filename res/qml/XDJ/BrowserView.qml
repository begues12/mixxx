import ".." as Skin
import QtQuick 2.12
import QtQuick.Layouts

// Modo BROWSE estilo Pioneer: biblioteca (con la fuente Rekordbox
// para USB) y franja inferior con el estado de los decks.
Rectangle {
    id: root

    color: "#000000"

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Skin.Library {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        DeckStrip {
            Layout.fillWidth: true
            Layout.preferredHeight: 78
        }
    }
}

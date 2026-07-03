import ".." as Skin
import QtQuick 2.12
import QtQuick.Layouts
import "../Theme"

// Modo Performance: 2 decks grandes con waveforms horizontales
// alineadas, como en una XDJ.
Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 4

        XDJDeck {
            Layout.fillHeight: true
            Layout.fillWidth: true
            deckColor: "#00b4ff"
            group: "[Channel1]"
        }
        XDJDeck {
            Layout.fillHeight: true
            Layout.fillWidth: true
            deckColor: "#ff9500"
            group: "[Channel2]"
        }
    }
}

import QtQuick 2.12
import QtQuick.Layouts

// Franja inferior con el estado de los dos decks, visible en todos
// los modos, como en las XDJ.
RowLayout {
    id: root

    spacing: 2

    DeckMiniTile {
        Layout.fillHeight: true
        Layout.fillWidth: true
        deckColor: "#00b4ff"
        deckNumber: 1
        group: "[Channel1]"
    }
    DeckMiniTile {
        Layout.fillHeight: true
        Layout.fillWidth: true
        deckColor: "#ff9500"
        deckNumber: 2
        group: "[Channel2]"
    }
}

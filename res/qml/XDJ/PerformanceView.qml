import ".." as Skin
import QtQuick 2.12
import QtQuick.Layouts

// Modo WAVEFORM estilo Pioneer: columna lateral con info de los
// decks, waveforms grandes apiladas y alineadas, bancos de hot cues
// y franja inferior con el estado de los decks.
Rectangle {
    id: root

    color: "#000000"

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        // Zona superior: tiles laterales + waveforms
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 2

            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 130
                spacing: 2

                DeckSideTile {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    deckColor: "#00b4ff"
                    deckNumber: 1
                    group: "[Channel1]"
                }
                DeckSideTile {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    deckColor: "#ff9500"
                    deckNumber: 2
                    group: "[Channel2]"
                }
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 2

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#000000"

                    Skin.WaveformDisplay {
                        anchors.fill: parent
                        group: "[Channel1]"
                    }
                }
                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#000000"

                    Skin.WaveformDisplay {
                        anchors.fill: parent
                        group: "[Channel2]"
                    }
                }
            }
        }
        // Bancos de hot cues
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            spacing: 8

            HotcueBank {
                Layout.fillHeight: true
                Layout.fillWidth: true
                group: "[Channel1]"
            }
            HotcueBank {
                Layout.fillHeight: true
                Layout.fillWidth: true
                group: "[Channel2]"
            }
        }
        DeckStrip {
            Layout.fillWidth: true
            Layout.preferredHeight: 78
        }
    }
}

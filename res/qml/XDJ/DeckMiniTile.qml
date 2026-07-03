import ".." as Skin
import "../Deck" as Deck
import Mixxx 1.0 as Mixxx
import QtQuick 2.12
import QtQuick.Layouts

// Tile inferior de deck estilo Pioneer: número, título, key, tiempo
// REMAIN grande, waveform overview y caja de BPM.
Rectangle {
    id: root

    required property string group
    required property int deckNumber
    required property color deckColor

    readonly property var deckPlayer: Mixxx.PlayerManager.getPlayer(group)
    readonly property var currentTrack: deckPlayer?.currentTrack
    readonly property bool loaded: deckPlayer?.isLoaded ?? false

    border.color: "#2a2a2a"
    border.width: 1
    color: "#000000"

    Mixxx.ControlProxy {
        id: bpmControl

        group: root.group
        key: "bpm"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 2
        spacing: 2

        // Fila superior: número de deck + título + key
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 18
            spacing: 4

            Rectangle {
                Layout.fillHeight: true
                color: root.deckColor
                width: 18

                Text {
                    anchors.centerIn: parent
                    color: "#000000"
                    font.bold: true
                    font.pixelSize: 12
                    text: root.deckNumber
                }
            }
            Text {
                Layout.fillWidth: true
                color: "#ffffff"
                elide: Text.ElideRight
                font.pixelSize: 12
                text: root.loaded ? `♪ ${root.currentTrack?.title ?? ""}` : ""
            }
            Text {
                color: "#9a9a9a"
                font.bold: true
                font.pixelSize: 12
                text: root.loaded ? (root.currentTrack?.keyText || "") : ""
            }
        }
        // Fila inferior: REMAIN + overview + BPM
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 4

            ColumnLayout {
                Layout.fillHeight: true
                spacing: 0

                Text {
                    color: "#7a7a7a"
                    font.pixelSize: 8
                    text: "REMAIN /\nTIME"
                }
                Deck.TrackTime {
                    id: remainTime

                    Layout.fillHeight: true
                    color: "#ffffff"
                    display: Deck.TrackTime.Display.Remaining
                    font.bold: true
                    font.pixelSize: 22
                    group: root.group
                    mode: Deck.TrackTime.Mode.TraditionalCoarse
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Skin.WaveformOverview {
                Layout.fillHeight: true
                Layout.fillWidth: true
                group: root.group
            }
            ColumnLayout {
                Layout.fillHeight: true
                spacing: 0

                Text {
                    Layout.alignment: Qt.AlignRight
                    color: "#7a7a7a"
                    font.pixelSize: 8
                    text: "BPM"
                }
                Text {
                    Layout.alignment: Qt.AlignRight
                    color: "#ffffff"
                    font.bold: true
                    font.pixelSize: 20
                    text: root.loaded ? bpmControl.value.toFixed(1) : "--"
                }
            }
        }
    }
}

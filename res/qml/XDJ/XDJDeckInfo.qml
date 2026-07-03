import ".." as Skin
import "../Deck" as Deck
import Mixxx 1.0 as Mixxx
import QtQuick 2.12
import QtQuick.Layouts
import "../Theme"

// Franja de información de un deck estilo XDJ: título, artista,
// BPM, key y tiempo restante. Pensada para pantalla táctil de 8".
Rectangle {
    id: root

    required property string group
    required property color deckColor

    readonly property var deckPlayer: Mixxx.PlayerManager.getPlayer(group)
    readonly property var currentTrack: deckPlayer?.currentTrack
    readonly property bool loaded: deckPlayer?.isLoaded ?? false

    color: Theme.deckBackgroundColor
    radius: 4

    Mixxx.ControlProxy {
        id: bpmControl

        group: root.group
        key: "bpm"
    }
    Mixxx.ControlProxy {
        id: rateRatioControl

        group: root.group
        key: "rate_ratio"
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 16

        Rectangle {
            Layout.fillHeight: true
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            color: root.deckColor
            radius: 2
            width: 6
        }
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                Layout.fillWidth: true
                color: Theme.white
                elide: Text.ElideRight
                font.bold: true
                font.pixelSize: 22
                text: root.loaded ? (root.currentTrack?.title ?? "") : qsTr("No track loaded")
            }
            Text {
                Layout.fillWidth: true
                color: Theme.deckTextColor
                elide: Text.ElideRight
                font.pixelSize: 16
                text: root.currentTrack?.artist ?? ""
                visible: root.loaded
            }
        }
        InfoCell {
            label: "BPM"
            value: root.loaded ? bpmControl.value.toFixed(1) : "--"
        }
        InfoCell {
            label: "KEY"
            value: root.loaded ? (root.currentTrack?.keyText || "--") : "--"
        }
        InfoCell {
            label: "TEMPO"
            value: `${((rateRatioControl.value - 1) * 100).toFixed(1)}%`
        }
        InfoCell {
            id: timeCell

            label: qsTr("REMAIN")
            value: time.text

            Deck.TrackTime {
                id: time

                display: Deck.TrackTime.Display.Remaining
                group: root.group
                mode: Deck.TrackTime.Mode.TraditionalCoarse
                visible: false
            }
        }
    }

    component InfoCell: ColumnLayout {
        property alias label: labelText.text
        property alias value: valueText.text

        spacing: 0

        Text {
            id: labelText

            Layout.alignment: Qt.AlignHCenter
            color: Theme.deckTextColor
            font.pixelSize: 11
        }
        Text {
            id: valueText

            Layout.alignment: Qt.AlignHCenter
            color: Theme.white
            font.bold: true
            font.pixelSize: 24
        }
    }
}

import Mixxx 1.0 as Mixxx
import QtQuick 2.12
import QtQuick.Layouts

// Columna lateral de deck en el modo WAVEFORM (estilo Pioneer):
// cabecera DECK n, fuente, KEY, BEAT JUMP y quantize.
Rectangle {
    id: root

    required property string group
    required property int deckNumber
    required property color deckColor

    readonly property var deckPlayer: Mixxx.PlayerManager.getPlayer(group)
    readonly property var currentTrack: deckPlayer?.currentTrack
    readonly property bool loaded: deckPlayer?.isLoaded ?? false

    color: "#141414"

    Mixxx.ControlProxy {
        id: beatjumpSizeControl

        group: root.group
        key: "beatjump_size"
    }
    Mixxx.ControlProxy {
        id: quantizeControl

        group: root.group
        key: "quantize"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 1

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 22
            color: root.deckColor

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.verticalCenter: parent.verticalCenter
                color: "#000000"
                font.bold: true
                font.pixelSize: 13
                text: `DECK ${root.deckNumber}`
            }
        }
        SideRow {
            label: "KEY"
            value: root.loaded ? (root.currentTrack?.keyText || "--") : "--"
            valueColor: root.loaded ? "#ffffff" : "#5a5a5a"
        }
        SideRow {
            label: "BEAT\nJUMP"
            value: beatjumpSizeControl.value.toFixed(0)
        }
        SideRow {
            label: "Q"
            value: quantizeControl.value > 0 ? "ON" : "OFF"
            valueColor: quantizeControl.value > 0 ? "#ff9500" : "#5a5a5a"

            MouseArea {
                anchors.fill: parent

                onClicked: quantizeControl.value = quantizeControl.value > 0 ? 0 : 1
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }

    component SideRow: Rectangle {
        property alias label: labelText.text
        property alias value: valueText.text
        property alias valueColor: valueText.color

        Layout.fillWidth: true
        Layout.preferredHeight: 34
        color: "#1e1e1e"

        Text {
            id: labelText

            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            color: "#7a7a7a"
            font.pixelSize: 9
        }
        Text {
            id: valueText

            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 15
        }
    }
}

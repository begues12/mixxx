import ".." as Skin
import Mixxx 1.0 as Mixxx
import QtQuick 2.12
import QtQuick.Layouts
import "../Theme"

// Deck completo estilo XDJ: info + waveform grande + fila de
// hot cues y transporte táctil.
Item {
    id: root

    required property string group
    required property color deckColor

    Mixxx.ControlProxy {
        id: playControl

        group: root.group
        key: "play"
    }
    Mixxx.ControlProxy {
        id: cueControl

        group: root.group
        key: "cue_default"
    }
    Mixxx.ControlProxy {
        id: syncControl

        group: root.group
        key: "sync_enabled"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        XDJDeckInfo {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            deckColor: root.deckColor
            group: root.group
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.color: Theme.deckLineColor
            border.width: 1
            color: "black"
            radius: 4

            Skin.WaveformDisplay {
                anchors.fill: parent
                anchors.margins: 2
                group: root.group
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            spacing: 4

            TouchButton {
                id: playButton

                activeColor: "#00c853"
                checked: playControl.value > 0
                text: playControl.value > 0 ? "❚❚" : "▶"

                onClicked: playControl.value = playControl.value > 0 ? 0 : 1
            }
            TouchButton {
                id: cueButton

                activeColor: "#ff6f00"
                text: "CUE"

                onPressed: cueControl.value = 1
                onReleased: cueControl.value = 0
                onCanceled: cueControl.value = 0
            }
            TouchButton {
                id: syncButton

                activeColor: root.deckColor
                checked: syncControl.value > 0
                text: "SYNC"

                onClicked: syncControl.value = syncControl.value > 0 ? 0 : 1
            }
            Repeater {
                model: 8

                Skin.HotcueButton {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    group: root.group
                    hotcueNumber: index + 1
                }
            }
        }
    }

    component TouchButton: Skin.Button {
        Layout.fillHeight: true
        Layout.preferredWidth: 72
        checkable: false
        font.pixelSize: 15
        highlight: checked
    }
}

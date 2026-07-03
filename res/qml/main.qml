import "." as Skin
import "XDJ" as XDJ
import Mixxx 1.0 as Mixxx
import QtQuick 2.12
import QtQuick.Layouts
import QtQuick.Window
import "Theme"

// Skin XDJ standalone: sin menús de escritorio, tres modos
// (Performance / Browse / Settings) pensados para pantalla táctil
// de 8" (1280x800) y control principal desde la FLX-4.
ApplicationWindow {
    id: root

    readonly property int numDecks: 2
    readonly property int numPreviewDecks: 1
    readonly property int numSamplers: 0
    readonly property int waveformOverviewTypeRgb: 2

    color: "#000000"
    height: 800
    minimumHeight: 480
    minimumWidth: 800
    visibility: Window.FullScreen
    visible: true
    width: 1280

    Mixxx.ControlProxy {
        group: "[App]"
        key: "num_decks"

        onInitializedChanged: {
            value = root.numDecks;
        }
    }
    Mixxx.ControlProxy {
        group: "[App]"
        key: "num_samplers"

        onInitializedChanged: {
            value = root.numSamplers;
        }
    }
    Mixxx.ControlProxy {
        group: "[App]"
        key: "num_preview_decks"

        onInitializedChanged: {
            value = root.numPreviewDecks;
        }
    }
    Mixxx.ControlProxy {
        group: "[Waveform]"
        key: "WaveformOverviewType"

        onInitializedChanged: {
            value = root.waveformOverviewTypeRgb;
        }
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        XDJ.ModeBar {
            id: modeBar

            Layout.fillWidth: true
            Layout.preferredHeight: 44
        }
        StackLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: modeBar.currentMode

            XDJ.PerformanceView {
            }
            XDJ.BrowserView {
            }
            XDJ.SettingsView {
            }
        }
    }
}

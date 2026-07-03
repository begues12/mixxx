import QtQuick 2.12
import QtQuick.Layouts

// Barra superior negra estilo Pioneer: título del modo actual,
// botones de modo planos con resaltado azul y reloj.
Rectangle {
    id: root

    // 0 = Waveform, 1 = Browse, 2 = Settings
    property int currentMode: 0

    color: "#000000"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            Layout.leftMargin: 16
            Layout.preferredWidth: 170
            color: "#ffffff"
            font.bold: true
            font.letterSpacing: 2
            font.pixelSize: 20
            text: ["WAVEFORM", "BROWSE", "SETTINGS"][root.currentMode]
        }
        Item {
            Layout.fillWidth: true
        }
        ModeButton {
            mode: 0
            text: "WAVEFORM"
        }
        ModeButton {
            mode: 1
            text: "BROWSE"
        }
        ModeButton {
            mode: 2
            text: "SETTINGS"
        }
        Item {
            Layout.preferredWidth: 16
        }
        Text {
            id: clock

            Layout.rightMargin: 16
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 16

            Timer {
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true

                onTriggered: clock.text = new Date().toLocaleTimeString(Qt.locale(), "HH:mm")
            }
        }
    }
    Rectangle {
        anchors.bottom: parent.bottom
        color: "#2a2a2a"
        height: 1
        width: parent.width
    }

    component ModeButton: Rectangle {
        required property int mode
        property alias text: label.text
        readonly property bool active: root.currentMode === mode

        Layout.fillHeight: true
        color: active ? "#0d84ff" : "#000000"
        implicitWidth: 120

        Text {
            id: label

            anchors.centerIn: parent
            color: parent.active ? "#ffffff" : "#8a8a8a"
            font.bold: true
            font.pixelSize: 13
        }
        MouseArea {
            anchors.fill: parent

            onClicked: root.currentMode = parent.mode
        }
    }
}

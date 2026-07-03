import ".." as Skin
import QtQuick 2.12
import QtQuick.Layouts
import "../Theme"

// Barra superior estilo XDJ: cambio de modo (Performance / Browse /
// Settings), crossfader/mixer compacto no incluido aquí, y reloj.
Rectangle {
    id: root

    // 0 = Performance, 1 = Browse, 2 = Settings
    property int currentMode: 0

    color: Theme.toolbarBackgroundColor

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 8

        ModeButton {
            mode: 0
            text: qsTr("PERFORM")
        }
        ModeButton {
            mode: 1
            text: qsTr("BROWSE")
        }
        ModeButton {
            mode: 2
            text: qsTr("SETTINGS")
        }
        Item {
            Layout.fillWidth: true
        }
        Text {
            id: clock

            color: Theme.white
            font.bold: true
            font.pixelSize: 18

            Timer {
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true

                onTriggered: clock.text = new Date().toLocaleTimeString(Qt.locale(), "HH:mm")
            }
        }
    }

    component ModeButton: Skin.Button {
        required property int mode

        Layout.fillHeight: true
        Layout.preferredWidth: 110
        Layout.topMargin: 4
        Layout.bottomMargin: 4
        activeColor: Theme.white
        checkable: false
        highlight: root.currentMode === mode

        onClicked: root.currentMode = mode
    }
}

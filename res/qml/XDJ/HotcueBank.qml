import ".." as Skin
import QtQuick 2.12
import QtQuick.Layouts

// Banco de 8 hot cues con chips coloreados estilo Pioneer,
// dispuestos en 2 filas de 4.
GridLayout {
    id: root

    required property string group

    columnSpacing: 3
    columns: 4
    rowSpacing: 3

    Repeater {
        model: 8

        Rectangle {
            id: chip

            required property int index
            readonly property int hotcueNumber: index + 1

            Layout.fillHeight: true
            Layout.fillWidth: true
            color: hotcue.isSet ? "#1e1e1e" : "#101010"

            Skin.Hotcue {
                id: hotcue

                group: root.group
                hotcueNumber: chip.hotcueNumber
            }
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.top: parent.top
                color: hotcue.isSet ? hotcue.color : "#2a2a2a"
                width: 16

                Text {
                    anchors.centerIn: parent
                    color: "#000000"
                    font.bold: true
                    font.pixelSize: 11
                    // Letras A..H como en las XDJ
                    text: String.fromCharCode(64 + chip.hotcueNumber)
                }
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 21
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: hotcue.isSet ? "#ffffff" : "#4a4a4a"
                elide: Text.ElideRight
                font.pixelSize: 10
                text: hotcue.isSet ? `Cue ${chip.hotcueNumber}` : "-"
            }
            MouseArea {
                anchors.fill: parent

                onPressed: hotcue.activate = 1
                onReleased: hotcue.activate = 0
                onCanceled: hotcue.activate = 0
            }
        }
    }
}

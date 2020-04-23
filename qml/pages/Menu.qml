import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: menu.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Leaderboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LeaderBoard.qml"), {modes: menu.help_modes})
            }
        }

        Column {
            property var help: 0
            property var help_modes: [qsTr("None"), qsTr("Counter"), qsTr("Bar"), qsTr("Both")]

            id: menu
            width: page.width
            height: page.height
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Binary Fun")
            }

            ButtonLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rowSpacing: Theme.paddingLarge * 2

                Button {
                    text: qsTr("Help") + ": " + menu.help_modes[menu.help]
                    onClicked: {
                        menu.help = menu.help !== 3 ? ++menu.help : 0;
                    }
                }

                Button {
                    text: qsTr("Very easy (2 Bit)")
                    ButtonLayout.newLine: true
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 2, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Easy (4 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 4, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Medium (6 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 6, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("Hard (8 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 8, help: menu.help, modes: menu.help_modes});
                    }
                }

                Button {
                    text: qsTr("God-like (10 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 10, help: menu.help, modes: menu.help_modes});
                    }
                }
            }
        }
    }
}

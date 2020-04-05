import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Leaderboard")
                onClicked: pageStack.push(Qt.resolvedUrl("LeaderBoard.qml"))
            }
        }

        Column {
            property bool bar: false

            id: column
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
                    text: qsTr("Help bar") + ": 0"
                    onClicked: {
                        column.bar = this.text.slice(-1) === "0";
                        this.text = column.bar ? qsTr("Help bar") + ": 1" : qsTr("Help bar") + ": 0"
                    }
                }

                Button {
                    text: qsTr("Very easy (2 Bit)")
                    ButtonLayout.newLine: true
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 2, help: column.bar});
                    }
                }

                Button {
                    text: qsTr("Easy (4 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 4, help: column.bar});
                    }
                }

                Button {
                    text: qsTr("Medium (6 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 6, help: column.bar});
                    }
                }

                Button {
                    text: qsTr("Hard (8 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 8, help: column.bar});
                    }
                }

                Button {
                    text: qsTr("God-like (10 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 10, help: column.bar});
                    }
                }
            }
        }
    }
}

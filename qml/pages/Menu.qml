import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
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
                    text: qsTr("Very easy (2 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 2});
                    }
                }

                Button {
                    text: qsTr("Easy (4 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 4});
                    }
                }

                Button {
                    text: qsTr("Medium (6 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 6});
                    }
                }

                Button {
                    text: qsTr("Hard (8 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 8});
                    }
                }

                Button {
                    text: qsTr("God-like (10 Bit)")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("Game.qml"), {bits: 10});
                    }
                }
            }
        }
    }
}

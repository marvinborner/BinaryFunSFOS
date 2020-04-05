import QtQuick 2.2
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium

        PageHeader {
            title: qsTr("Leaderboard")
        }

        TextField {
            placeholderText: "Enter username (default: anon)"
            text: username.value
            label: "Username"
            width: page.width
            EnterKey.enabled: text.length > 0 && text.length <= 16
            EnterKey.iconSource: "image://theme/icon-m-enter-close"
            EnterKey.onClicked: {
                focus = false
                username.value = text
            }
        }

        ComboBox {
            id: selector
            label: "Difficulty"

            function select(diff) {
                var xhr = new XMLHttpRequest()
                xhr.open("GET",
                         "https://marvinborner.de/lead/binaryfun1/list?sort=time&order=asc&count=1000&filter=difficulty,"+diff,
                         false)
                xhr.send()
                if (xhr.status !== 0) {
                    list.model = JSON.parse(xhr.responseText);
                    internet.visible = false;
                } else {
                    internet.visible = true;
                }
            }

            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Please select")
                }
                MenuItem {
                    property int diff: 2
                    text: qsTr("Very easy (2 Bit)")
                    onClicked: selector.select(diff)
                }
                MenuItem {
                    property int diff: 4
                    text: qsTr("Easy (4 Bit)")
                    onClicked: selector.select(diff)
                }
                MenuItem {
                    property int diff: 6
                    text: qsTr("Medium (6 Bit)")
                    onClicked: selector.select(diff)
                }
                MenuItem {
                    property int diff: 8
                    text: qsTr("Hard (8 Bit)")
                    onClicked: selector.select(diff)
                }
                MenuItem {
                    property int diff: 10
                    text: qsTr("God-like (10 Bit)")
                    onClicked: selector.select(diff)
                }
            }
        }

        Label {
            id: internet
            text: qsTr("No internet connection!")
            visible: false
        }

        ListView {
            id: list
            clip: true
            width: page.width
            height: page.height - y
            model: []
            delegate: ListItem {
                contentHeight: Theme.itemSizeMedium

                Label {
                    id: name
                    text: index + 1 + ". " + modelData.name
                }

                Label {
                    anchors.top: name.bottom
                    text: ((modelData.end_time[1] - modelData.start_time[1]) / 1000) + "s - Help: " + modelData.cheats
                    font.pixelSize: Theme.fontSizeSmall
                }
            }
        }
    }

    ConfigurationValue {
        id: username
        key: "/com/binaryfun/username"
        defaultValue: "anon"
    }
}

import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

Page {
    property var modes: []

    id: page
    allowedOrientations: Orientation.Portrait

    Column {
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium

        PageHeader {
            title: qsTr("Leaderboard")
        }

        TextField {
            placeholderText: qsTr("Enter username (default: anon)")
            text: username.value
            label: qsTr("Username")
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
            label: qsTr("Difficulty")

            function select(diff) {
                var xhr = new XMLHttpRequest()
                xhr.open("GET",
                         "https://marvinborner.de/lead/binaryfun1/list?sort=time&order=asc&count=1000&filter=difficulty,"+diff,
                         true)
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        list.model = JSON.parse(xhr.responseText).sort(function(a, b){
                            const time_a = ((a.end_time[1] - a.start_time[1]) / 1000) + (a.mods === "0" ? 1.0 : 0)
                            const time_b = ((b.end_time[1] - b.start_time[1]) / 1000) + (b.mods === "0" ? 1.0 : 0)
                            return time_a - time_b;
                        });;
                        internet.visible = false;
                        loading.running = false;
                    } else if (xhr.readyState === 4) {
                        internet.visible = true;
                        loading.running = false;
                    }
                }
                xhr.send()
                list.model = [];
                loading.running = true;
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
            text: qsTr("Please try again later.")
            visible: false
        }

        BusyIndicator {
            id: loading
            size: BusyIndicatorSize.Large
            anchors.horizontalCenter: parent.horizontalCenter
            running: false
            visible: running
        }

        SilicaListView {
            id: list
            clip: true
            quickScroll: true
            width: page.width
            height: page.height - y
            model: []
            delegate: ListItem {
                id: score
                contentHeight: Theme.itemSizeLarge

                Label {
                    id: name
                    text: index + 1 + ". " + modelData.name
                }

                Label {
                    id: level
                    anchors.top: name.bottom
                    text: {
                        var numbers = modelData.level.split(",").slice(
                              modelData.difficulty).filter(function (_, i) {
                                  return i % (modelData.difficulty + 1) === 0.
                              }).slice(1);
                        if (numbers.length !== modelData.difficulty && modelData.difficulty !== 10) {
                            console.log("Tempered: " + numbers.length + " " + modelData.difficulty);
                            score.visible = false;
                        }

                        return qsTr("Numbers: ") + numbers.join(", ");
                    }
                    font.pixelSize: Theme.fontSizeExtraSmall
                }

                Label {
                    anchors.top: level.bottom
                    text: {
                        const time = (((modelData.end_time[1] - modelData.start_time[1]) / 1000) + (modelData.mods === "0" ? 1.0 : 0)).toFixed(3);
                        const help = modelData.cheats === "true" ? 3 : (modelData.cheats === "false" ? 1 : parseInt(modelData.cheats));
                        return time + qsTr("s - Help: ") + page.modes[help];
                    }
                    font.pixelSize: Theme.fontSizeExtraSmall
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

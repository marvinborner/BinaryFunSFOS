import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property var pads: [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ];

    function check(row, index, checked) {
        pads[row][index] = checked ? 1 : 0;
    }

    function getRandom() {
        return Math.floor(Math.random() * 16);
    }

    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter

            PageHeader {
                title: qsTr("Binary Fun")
            }

            Grid {
                anchors.horizontalCenter: parent.horizontalCenter
                columns: 5

                // UGLINESS STARTS IN 3.. 2.. 1.. !

                Switch {
                    onClicked: check(0, 4, checked)
                }

                Switch {
                    onClicked: check(0, 3, checked)
                }

                Switch {
                    onClicked: check(0, 2, checked)
                }

                Switch {
                    onClicked: check(0, 1, checked)
                }

                Label {
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(1, 4, checked)
                }

                Switch {
                    onClicked: check(1, 3, checked)
                }

                Switch {
                    onClicked: check(1, 2, checked)
                }

                Switch {
                    onClicked: check(1, 1, checked)
                }

                Label {
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(2, 4, checked)
                }

                Switch {
                    onClicked: check(2, 3, checked)
                }

                Switch {
                    onClicked: check(2, 2, checked)
                }

                Switch {
                    onClicked: check(2, 1, checked)
                }

                Label {
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(3, 4, checked)
                }

                Switch {
                    onClicked: check(3, 3, checked)
                }

                Switch {
                    onClicked: check(3, 2, checked)
                }

                Switch {
                    onClicked: check(3, 1, checked)
                }

                Label {
                    text: getRandom()
                }
            }
        }
    }
}

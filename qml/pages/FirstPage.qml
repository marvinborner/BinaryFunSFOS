import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property var correctBinary: [];

    property var pads: [
        ["0", "0", "0", "0"],
        ["0", "0", "0", "0"],
        ["0", "0", "0", "0"],
        ["0", "0", "0", "0"]
    ];

    property var correctRows: {
        "0": false,
        "1": false,
        "2": false,
        "3": false
    }

    function check(row, index, checked) {
        pads[row][index] = checked ? "1" : "0";
        const typedBinary = parseInt(pads[row].join(""));
        const neededBinary = parseInt(dec2bin(eval("rand_" + row).text));
        correctRows[row.toString()] = typedBinary === neededBinary;
        console.log(JSON.stringify(correctRows));
        if (Object.keys(correctRows).every(function(k){ return correctRows[k] }))
            gameover.text = "Yeeha!";
        else
            gameover.text = "";
    }

    function dec2bin(dec){
        return parseInt((dec >>> 0).toString(2));
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
                    onClicked: check(0, 0, checked)
                }

                Switch {
                    onClicked: check(0, 1, checked)
                }

                Switch {
                    onClicked: check(0, 2, checked)
                }

                Switch {
                    onClicked: check(0, 3, checked)
                }

                Label {
                    id: rand_0
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(1, 0, checked)
                }

                Switch {
                    onClicked: check(1, 1, checked)
                }

                Switch {
                    onClicked: check(1, 2, checked)
                }

                Switch {
                    onClicked: check(1, 3, checked)
                }

                Label {
                    id: rand_1
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(2, 0, checked)
                }

                Switch {
                    onClicked: check(2, 1, checked)
                }

                Switch {
                    onClicked: check(2, 2, checked)
                }

                Switch {
                    onClicked: check(2, 3, checked)
                }

                Label {
                    id: rand_2
                    text: getRandom()
                }

                //

                Switch {
                    onClicked: check(3, 0, checked)
                }

                Switch {
                    onClicked: check(3, 1, checked)
                }

                Switch {
                    onClicked: check(3, 2, checked)
                }

                Switch {
                    onClicked: check(3, 3, checked)
                }

                Label {
                    id: rand_3
                    text: getRandom()
                }
            }

            Label {
                id: gameover
            }
        }
    }
}

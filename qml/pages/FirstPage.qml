import QtQuick 2.2
import Sailfish.Silica 1.0
import ".."

ApplicationWindow {
    initialPage: pageComponent

    Component {
        id: pageComponent

        Page {
            id: page
            allowedOrientations: Orientation.All

            SilicaFlickable {
                anchors.fill: parent
                contentHeight: root.height

                PullDownMenu {
                    MenuItem {
                        text: qsTr("Leaderboard")
                        onClicked: pageStack.push(Qt.resolvedUrl("LeaderBoard.qml"))
                    }
                }

                Column {
                    property int bits: 4
                    property var correct: new Array(bits)
                    property var matrix: new Array(Math.pow(bits + 1, 2))

                    id: root
                    width: page.width
                    height: page.height
                    spacing: Theme.paddingLarge

                    PageHeader {
                        title: qsTr("Binary Fun")
                    }

                    function nearest(number) {
                        if (number % (bits + 1) === 0) {
                            return number
                        } else {
                            return number - (number % (bits + 1))
                        }
                    }

                    function check(index) {
                        root.matrix[index] ^= 1;
                        var near = nearest(index);

                        if (Number(root.matrix.slice(near, near + bits).join("")).toString() === (root.matrix[near + bits] >>> 0).toString(2)) {
                            correct[near / (bits + 1) - 1] = 1;
                            info_label.text = parseInt(info_label.text.substr(0, info_label.text.indexOf('/'))) + 1 + " / " + root.bits;
                        } else {
                            correct[near / (bits + 1) - 1] = 0;
                        }

                        if (correct.filter(function(i) { return i === 1 }).length === bits) {
                            info_label.text = "Yeeehaa!";
                            timer.running = false;
                        }
                    }

                    Grid {
                        property int row: 0

                        id: grid
                        anchors.bottom: page.bottom
                        columns: root.bits + 1
                        rows: root.bits + 1
                        Repeater {
                            id: repeater
                            model: Math.pow(root.bits + 1, 2)
                            delegate: Bit {
                                bits: root.bits
                                index: modelData
                                width: page.width / (root.bits + 1)
                            }
                        }
                    }

                    Label {
                        id: info_label
                        text: "0 / " + root.bits
                        anchors.horizontalCenter: parent.horizontalCenter
                        // anchors.top: grid.bottom
                        anchors.bottom: page.bottom
                    }

                    Label {
                        id: timer_label
                        text: "0.0"
                        anchors.horizontalCenter: parent.horizontalCenter
                        // anchors.top: won.bottom
                        anchors.bottom: page.bottom
                    }

                    Timer {
                        id: timer
                        interval: 1
                        running: true
                        repeat: true
                        onTriggered: timer_label.text = (parseFloat(timer_label.text) + 0.01).toFixed(2).toString()
                    }
                }
            }
        }
    }
}

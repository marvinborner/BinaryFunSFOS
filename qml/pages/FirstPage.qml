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
                        onClicked: pageStack.push(Qt.resolvedUrl(
                                                      "LeaderBoard.qml"))
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
                        title: "Binary Fun"
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
                        } else {
                            correct[near / (bits + 1) - 1] = 0;
                        }

                        if (correct.filter(function(i) { return i === 1 }).length === bits) {
                            console.log("WON!!");
                        }
                    }

                    Grid {
                        id: grid
                        anchors.verticalCenter: parent.verticalCenter
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
                }
            }
        }
    }
}

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
                    property var matrix: new Array(Math.pow(bits + 1, 2))

                    id: root
                    width: page.width
                    height: page.height
                    spacing: Theme.paddingLarge

                    PageHeader {
                        title: "Binary Fun"
                    }

                    function check(index) {
                        root.matrix[index] ^= 1;
                        console.log(root.matrix);
                        console.log(Number(root.matrix.slice(5, 9).join("")).toString());
                        console.log(parseInt((root.matrix[9] >>> 0).toString(2)));

                        if (Number(root.matrix.slice(5, 9).join("")).toString() === (root.matrix[9] >>> 0).toString(2)) {
                            console.log("YAY");
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

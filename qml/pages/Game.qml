import QtQuick 2.2
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import ".."

Page {
    // Get passed by previous page
    property int bits: 0
    property bool help: false

    id: page
    allowedOrientations: Orientation.Portrait

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
            property int bits: page.bits
            property bool help: page.help
            property var correct: new Array(bits)
            property var matrix: new Array(Math.pow(bits + 1, 2))
            property var start_time: 0

            id: root
            width: page.width
            height: page.height
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Binary Fun")
            }

            function submit(start_time, end_time, difficulty, level) {
                var key = "RmMwQ0ptT1FlSkpIeEdzNDB3a1B5OVk1ZE8wYkRjSzI=";
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "https://marvinborner.de/lead/binaryfun1/add", true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
                var query = "writeKey=" + Qt.atob(key) + "&win=true&board=default&start_time=" + start_time
                        + "&end_time=" + end_time + "&difficulty=" + difficulty
                        + "&level=" + level + "&cheats=" + (root.help ? "true" : "false")
                        + "&name="+ username.value + "&mods=0" + "&time=" + (end_time - start_time);
                xhr.send(query);
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
                var current_score = parseInt(info_label.text.substr(0, info_label.text.indexOf('/')))

                if (Number(root.matrix.slice(near, near + bits).join("")).toString() === (root.matrix[near + bits] >>> 0).toString(2) && timer.running) {
                    correct[near / (bits + 1) - 1] = 1;
                    info_label.text = current_score + 1 + " / " + root.bits;
                } else {
                    if (correct[near / (bits + 1) - 1] === 1 && timer.running) {
                        info_label.text = current_score - 1 + " / " + root.bits;
                    }

                    correct[near / (bits + 1) - 1] = 0;
                }

                if (correct.filter(function(i) { return i === 1 }).length === bits) {
                    if (timer.running) { // aka still playing
                        var end_time = (new Date()).getTime();
                        info_label.text = "Yeeehaaw!";
                        timer_label.text = ((end_time - start_time) / 1000) + "s - " + qsTr("Not bad!");
                        timer.running = false;
                        new_game.visible = true;
                        submit(start_time, end_time, bits, root.matrix.join(","))
                    }
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
                anchors.bottom: page.bottom
            }

            Label {
                id: timer_label
                text: "0s"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: page.bottom
            }

            Timer {
                id: timer
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    if (root.start_time === 0)
                        root.start_time = (new Date()).getTime();
                    timer_label.text = parseInt(timer_label.text.substr(0, timer_label.text.indexOf('s'))) + 1 + "s";
                }
            }

            Button {
                id: new_game
                text: qsTr("Play again")
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: pageStack.replace(Qt.resolvedUrl("Game.qml"), {bits: root.bits})
            }
        }
    }

    ConfigurationValue {
        id: username
        key: "/com/binaryfun/username"
        defaultValue: "anon"
    }
}

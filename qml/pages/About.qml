// Written by Bill Halley
import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    SilicaFlickable {
        id: flickable
        anchors.fill: page
        contentHeight: column.height
        Column {
            id: column
            width: parent.width - Theme.paddingLarge * 2
            spacing: 20
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                top: page.top
            }

            Label {
                topPadding: Theme.paddingLarge
                width: parent.width
                text: qsTr("Fun with Binary numbers!")
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("The challenge of this game is to type a given decimal number in binary as fast as possible. You can also compete with people from all over the world via the leaderboard which is accessible from the pulley menu. Binary Fun is not only a game you can play while you're bored, but also a game which can help enhance your mathematical skills!")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }

            Label {
                width: parent.width
                text: qsTr("If you aren't that comfortable with the binary system yet, I suggest to start with the very easy mode and step up after some time.\nThere are also serveral help modes available:")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("1. None: No helping bar and no process indicator. Play this together with the god-like mode and you'll get frustrated very quickly!")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("2. Counter: Adds a process indicator/counter showing you how many lines you've got right.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("3. Bar: Replaces the top bar/line with helping numbers, showing you the decimal representation of the corresponding bit.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("4. Both: Activates both 2. and 3. - recommended for beginners.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Label {
                width: parent.width
                text: qsTr("All in all, I think that Binary Fun turned out great and I play it myself everyday while travelling with the train. Thank you for playing and I hope you learn to love the binary system as much as I do :)")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: Text.AlignJustify
                wrapMode: Text.WordWrap
            }
            Row {
                spacing: Theme.paddingLarge
                Label {
                    id: imageText
                    width: column.width / 2 - Theme.paddingMedium
                    textFormat: Text.RichText
                    text: "<style>a:link { color: " + Theme.highlightColor + "; }</style>" + qsTr(
                              "Follow the development on ")
                          + "<a href=https://openrepos.net/content/melvin/binary-fun>OpenRepos.net</a>" + qsTr(
                              " or GitHub and check for updates now and then. This app is completely written by melvin/marvinborner. If you like it, please consider making a small donation, I would really appreciate it!")
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall - 6
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(
                                         "https://openrepos.net/content/melvin/binary-fun")
                }
                Item {
                    height: imageText.height
                    width: imageText.width
                    Image {
                        id: image
                        height: imageText.height
                        width: imageText.width
                        fillMode: Image.PreserveAspectFit
                        source: "donation.png"
                    }
                    MouseArea {
                        width: image.width
                        height: image.height
                        anchors.fill: image
                        onClicked: {
                            Qt.openUrlExternally("https://www.paypal.me/marvinborner/")
                        }
                    }
                }
            }
        }

        VerticalScrollDecorator {
            flickable: flickable
        }
    }
}

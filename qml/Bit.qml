import QtQuick 2.0
import Sailfish.Silica 1.0

Loader {
    property int index: 0
    property int bits: 0

    Component {
        id: bit
        Switch {
            width: Theme.paddingLarge * 2
            height: width
            onClicked: root.check(index)
            Component.onCompleted: root.matrix[index] = 0
        }
    }

    Component {
        id: bit_index
        Label {
            text: parent.index.toString()
            width: Theme.paddingLarge * 2
            height: width
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            Component.onCompleted: {
                if (index > bits) {
                    var num = Math.floor(Math.random() * Math.pow(bits - 1, 2)) + 1;
                    this.text = num;
                    root.matrix[index] = num;
                } else {
                    this.text = "?";
                }
            }
        }
    }

    sourceComponent: (index % (bits + 1) == bits)
                     || (index <= bits) ? bit_index : bit
}

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

    function pad(n, width) {
        return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
    }

    Component {
        id: bit_index
        Label {
            id: bit_label
            color: Theme.highlightColor
            text: parent.index.toString()
            width: Theme.paddingLarge * 2
            height: width
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            Component.onCompleted: {
                // This code could definitely be improved ;)
                if (index > bits) {
                    grid.row++;

                    var indices = root.matrix.slice(0, bits);
                    var transformed = [];
                    indices.forEach(function(elem) {
                        transformed.push((pad((parseInt(elem) >>> 0).toString(2), bits))[grid.row - 1]);
                    });

                    var transformed_num = parseInt(transformed.join(""), 2);
                    this.text = transformed_num;
                    root.matrix[index] = transformed_num;
                    if (transformed_num === 0) { // A rather dumb fix.
                        root.check(index - 1);
                        root.check(index - 1);
                    }
                } else if (index !== bits){
                    var num = Math.floor(Math.random() * (Math.pow(2, bits) - 1)) + 1;
                    this.text = num;
                    root.matrix[index] = num;
                } else {
                    this.text = "0/1";
                }
            }
        }
    }

    sourceComponent: (index % (bits + 1) == bits)
                     || (index <= bits) ? bit_index : bit
}

import QtQuick

Window {
    minimumWidth: 260
    minimumHeight: 380
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    title: qsTr("Guitar Pedal")

    FontLoader {
        id: russoFontLoader
        source: "assets/fonts/RussoOne-Regular.ttf"
    }

    Image {
        id: padalBackgroound
        source: "assets/images/Guitar-Pedal-Background.png"
        anchors.fill: parent
    }

    Item {
        id: screw
        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        anchors.topMargin: 17
        anchors.bottomMargin: 17

        ScrewImage {
            anchors.top: parent.top
            anchors.left: parent.left
        }

        ScrewImage {
            anchors.top: parent.top
            anchors.right: parent.right
        }

        ScrewImage {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }

        ScrewImage {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }
    }

    component ScrewImage: Image {
        source: "assets/images/Screw.png"
    }

    component InfoText: Column {
        id: infoLabel
        spacing: 5
        property alias text: label.text
        property int lineWidth: 200
        property int lineHeight: 2
        property color rectColor: '#000'

        Rectangle {
            width: infoLabel.lineWidth
            height: infoLabel.lineHeight
            color: infoLabel.rectColor
        }

        Text {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: russoFontLoader.font.family
        }

        Rectangle {
            width: infoLabel.lineWidth
            height: infoLabel.lineHeight
            color: infoLabel.rectColor
        }
    }

    InfoText {
        text: qsTr("The Captaan")
        anchors.top: parent.verticalCenter
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }

    InfoText {
        text: qsTr("IN")
        lineWidth: 30
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    InfoText {
        text: qsTr("OUT")
        lineWidth: 30
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 20
    }

    component SwitchImage: Image {
        required property string sourceBaseName
        property bool checked
        source: `assets/images/${sourceBaseName}${checked ? "-Checked" : ""}.png`
    }
    component DeviceSwitch: SwitchImage {
        TapHandler {
            onTapped: parent.checked = !parent.checked
        }
    }

    SwitchImage {
        x: parent.width * 0.33 - width / 2
        y: 16
        sourceBaseName: "LED"
        checked: footPedal.checked
    }
    DeviceSwitch {
        x: parent.width * 0.66 - width / 2
        y: 16
        sourceBaseName: "Switch"
    }
    DeviceSwitch {
        id: footPedal
        sourceBaseName: "Button-Pedal"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 17
        anchors.horizontalCenter: parent.horizontalCenter
    }
    component DeviceDial: Image {
        id: dial
        source: "assets/images/Knob-Markings.png"

        property int value
        property real angle

        readonly property int minimumValue: 0
        readonly property int maximumValue: 100
        readonly property int range: dial.maximumValue - dial.minimumValue

        DragHandler {
            target: null
            onCentroidChanged: updateValueAndRotation()

            function updateValueAndRotation() {
                if (centroid.pressedButtons !== Qt.LeftButton) {
                    return;
                }

                const startAngle = -140;
                const endAngle = 140;

                const yy = dial.height / 2.0 - centroid.position.y;
                const xx = centroid.position.x - dial.width / 2.0;

                const radianAngle = Math.atan2(yy, xx);
                let newAngle = (-radianAngle / Math.PI * 180) + 90;

                newAngle = ((newAngle - dial.angle + 180) % 360) + dial.angle - 180;

                dial.angle = Math.max(startAngle, Math.min(newAngle, endAngle));
                dial.value = (dial.angle - startAngle) / (endAngle - startAngle) * dial.range;

                console.log("angle: ", dial.angle, "value: ", dial.value);
            }
        }
        Image {
            rotation: dial.angle
            anchors.centerIn: parent
            source: "assets/images/Knob-Dial.png"
        }
    }

    DeviceDial {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 67 - height / 2
    }
}

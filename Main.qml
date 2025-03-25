import QtQuick

Window {
    minimumWidth: 260
    minimumHeight: 380
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    title: qsTr("Guitar Pedal")

    FontLoader{
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

        component ScrewImage: Image {
            source: "assets/images/Screw.png"
        }

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

    component InfoText: Column{
        id: infoLabel
        spacing: 5
        property alias text : label.text
        property int lineWidth: 200
        property int lineHeight: 2
        property color rectColor: '#000'

        Rectangle{
            width: infoLabel.lineWidth
            height: infoLabel.lineHeight
            color: infoLabel.rectColor
        }

        Text {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: russoFontLoader.font.family
        }

        Rectangle{
            width: infoLabel.lineWidth
            height: infoLabel.lineHeight
            color: infoLabel.rectColor
        }
    }

    InfoText{
        text: qsTr("The Captaan")
        anchors.top: parent.verticalCenter
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }

    InfoText{
        text: qsTr("IN")
        lineWidth: 30
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    InfoText{
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
        source: `assets/images/${sourceBaseName}${checked ? "-Checked": ""}.png`
    }
    component DeviceSwitch: SwitchImage{
        TapHandler{
            onTapped: parent.checked = !parent.checked
        }
    }

    SwitchImage{
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
}

import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: topPanel
    width: parent.width
    height: parent.height * 0.1

    property string titleText: "Dummy"
    property string profileText: "AA"

    signal closeButtonClicked()

    background: Rectangle {
        color: "#FFFFFF"
    }

    Text {
        id: name
        text: qsTr(titleText)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: profilePanel
        width: parent.height * 0.5
        height: width
        radius: width * 0.5
        color: "grey"
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.06
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: qsTr(profileText)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.height * 0.35
        }
    }

    Rectangle {
        id: aboutPanel
        width: parent.height * 0.4
        height: width
        radius: width * 0.5
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.06
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: qsTr("x")
            rotation: 180
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.height * 1.5

            MouseArea {
                anchors.fill: parent
                onClicked: closeButtonClicked()
            }
        }
    }
}

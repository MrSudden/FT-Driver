import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: bottomPanel
    width: parent.width
    height: parent.height * 0.1
    padding: 0
//    width: 480
//    height: 640 * 0.1

    property string titleText: "Dummy Dummy"
    property string firstTabText: "Trip"
    property string secondTabText: "History"
    property string sel: "a"

    signal firstTabMAClicked()
    signal secondTabMAClicked()

    Rectangle {
        id: firstTab
        width: parent.width * 0.5
        height: parent.height
        color: (sel === "a") ? "#C0A8D8" : "#FFFFFF"
        opacity: 0.75
        anchors.left: parent.left
        anchors.top: parent.top

        Text {
            text: qsTr(firstTabText)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            font.family: "Open Sans Regular"
            font.pixelSize: parent.height * 0.2
        }

        MouseArea {
            id: firstTabMA
            anchors.fill: parent
            onClicked: firstTabMAClicked()
        }
    }

    Rectangle {
        id: secondTab
        width: parent.width * 0.5
        height: parent.height
        color: (sel === "b") ? "#C0A8D8" : "#FFFFFF"
        opacity: 0.75
        anchors.right: parent.right
        anchors.top: parent.top

        Text {
            text: qsTr(secondTabText)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            font.family: "Open Sans Regular"
            font.pixelSize: parent.height * 0.2
        }

        MouseArea {
            id: secondTabMA
            anchors.fill: parent
            onClicked: secondTabMAClicked()
        }
    }
}

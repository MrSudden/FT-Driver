import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: topPanel
    width: parent.width
    height: parent.height * 0.1
//    width: 480
//    height: 640 * 0.1

    property string titleText: "Dummy"
    property string profileText: "AA"

    signal profileMAClicked()
    signal aboutMAClicked()

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

        Image {
            id: profImage
            anchors.fill: parent
            source: "Futminna_BUS_MONITORING_2.png"
            fillMode: Image.PreserveAspectFit
        }

//        Text {
//            text: qsTr(profileText)
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
//            font.family: "Open Sans Regular"
//            font.pixelSize: parent.height * 0.35
//        }

//        MouseArea {
//            anchors.fill: parent
//            onClicked: profileMAClicked()
//        }
    }

    Rectangle {
        id: aboutPanel
        width: parent.height * 0.4
        height: width
        radius: width * 0.5
        border.width: 2
        border.color: "grey"
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.06
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: qsTr("!")
            rotation: 180
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.height * 0.5
        }

        MouseArea {
            anchors.fill: parent
            onClicked: aboutMAClicked()
        }
    }
}

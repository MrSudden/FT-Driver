import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: about
    title: qsTr("about")
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    signal closeMAClicked()

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    Text {
        id: close
        text: qsTr("x")
        width: parent.width * 0.1
        height: width
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05
        anchors.topMargin: anchors.rightMargin
        font.family: "Open Sans Regular"
        font.pixelSize: parent.height * 0.03
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        MouseArea {
            id: closeMA
            anchors.fill: parent
            onClicked: closeMAClicked()
        }
    }

    Text {
        id: aboutTextItem
        width: parent.width * 0.8
        text: qsTr("This is a research project.")
        font.family: "Open Sans Regular"
        font.pixelSize: parent.height * 0.03
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
    }
}

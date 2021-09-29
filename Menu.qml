import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: menu
    anchors.fill: parent

    property string profileParseText: "AA"

    signal cancelButtonMAClicked()
    signal buttonMAClicked()

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    MenuTopTabPanel {
        id: topPanel
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        titleText: "Menu"
        profileText: profileParseText
        onCloseButtonClicked: cancelButtonMAClicked()
    }

    Rectangle {
        id: panel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topPanel.bottom
        anchors.bottom: parent.bottom
        color: "#E6E6FA"

        Rectangle {
            id: buttonPanel
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: menu.width * 0.9
            implicitHeight: menu.height * 0.075
            color: "#d8c0d8"
            radius: menu.height * 0.02

            Text {
                id: buttonText
                text: qsTr("Sign out")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: menu.height * 0.025
                fontSizeMode: Text.Fit
                font.family: "Open Sans Regular"
            }

            MouseArea {
                id: buttonMA
                anchors.fill: parent
                onClicked: buttonMAClicked()
            }
        }
    }
}

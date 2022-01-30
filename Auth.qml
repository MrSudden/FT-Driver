import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: login
    title: qsTr("Login")
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    property alias authIdText: authIdTF.text
    property alias authKeyText: authKeyTF.text

    signal validateBtnClicked()

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    Image {
        id: logo
        source: "Futminna_BUS_MONITORING_2.png"
        fillMode: Image.PreserveAspectFit
        width: parent.height * 0.25
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
    }

    Text {
        id: authId
        text: qsTr("Autsh ID")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.03
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: logo.bottom
        anchors.topMargin: parent.height * 0.05
    }

    TextField {
        id: authIdTF
        width: parent.width * 0.8
        height: parent.height * 0.075
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: authId.bottom
        anchors.topMargin: parent.height * 0.0125
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.0375
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignLeft
        placeholderText: qsTr("DRV------")
        inputMethodHints: Qt.ImhEmailCharactersOnly

        background: Rectangle {
            border.width: 3
            border.color: "#C0A8D8"
            radius: login.height * 0.02
            opacity: 0.75
        }
    }

    Text {
        id: authKey
        text: qsTr("Auth KEY")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.03
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: authIdTF.bottom
        anchors.topMargin: parent.height * 0.025
    }

    TextField {
        id: authKeyTF
        width: parent.width * 0.8
        height: parent.height * 0.075
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: authKey.bottom
        anchors.topMargin: parent.height * 0.0125
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.0375
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignLeft
        placeholderText: qsTr("********")
        echoMode: TextInput.Password

        background: Rectangle {
            border.width: 3
            border.color: "#C0A8D8"
            radius: login.height * 0.02
            opacity: 0.75
        }
    }

    Button {
        id: validateBtn
        width: parent.width * 0.8
        height: parent.height * 0.06
        anchors.top: authKeyTF.bottom
        anchors.topMargin: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: validateBtnClicked()

        background: Rectangle {
            radius: login.height * 0.02
            opacity: 0.75
            color: "#C0A8D8"
        }

        contentItem: Text {
            id: validateButtonText
            text: qsTr("Validate")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.width * 0.05
        }
    }

}

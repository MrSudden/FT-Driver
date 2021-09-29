import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: login
    title: qsTr("Login")
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    property alias emailText: emailTF.text
    property alias passwordText: passwordTF.text

    signal loginBtnClicked()
    signal signupBtnClicked()
    signal forgotMAClicked()

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
        id: email
        text: qsTr("Email")
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
        id: emailTF
        width: parent.width * 0.8
        height: parent.height * 0.075
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: email.bottom
        anchors.topMargin: parent.height * 0.0125
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.0375
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignLeft
        placeholderText: qsTr("placeholder@email.com")
        inputMethodHints: Qt.ImhEmailCharactersOnly

        background: Rectangle {
            border.width: 3
            border.color: "#C0A8D8"
            radius: login.height * 0.02
            opacity: 0.75
        }
    }

    Text {
        id: password
        text: qsTr("Password")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.03
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: emailTF.bottom
        anchors.topMargin: parent.height * 0.025
    }

    TextField {
        id: passwordTF
        width: parent.width * 0.8
        height: parent.height * 0.075
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.1
        anchors.top: password.bottom
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

    Text {
        id: forgot
        text: qsTr("Forgot password?")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: "Open Sans Regular"
        font.pixelSize: parent.width * 0.03
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordTF.bottom
        anchors.topMargin: parent.height * 0.0125

        MouseArea {
            id: forgotMA
            anchors.fill: parent
            onClicked: forgotMAClicked()
        }
    }

    Button {
        id: loginBtn
        width: parent.width * 0.8
        height: parent.height * 0.06
        anchors.top: forgot.bottom
        anchors.topMargin: parent.height * 0.025
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: loginBtnClicked()

        background: Rectangle {
            radius: login.height * 0.02
            opacity: 0.75
            color: "#C0A8D8"
        }

        contentItem: Text {
            id: loginButtonText
            text: qsTr("Log in")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.width * 0.05
        }
    }

    ToolSeparator {
        id: seperator
        orientation: Qt.Horizontal
        width: parent.width * 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginBtn.bottom
        anchors.topMargin: parent.height * 0.025
        height: 3

        background: Rectangle {
            radius: seperator.width * 0.5
            color: "#C0A8D8"
            opacity: 0.75
        }
    }

    Button {
        id: signupBtn
        width: parent.width * 0.8
        height: parent.height * 0.06
        anchors.top: seperator.bottom
        anchors.topMargin: parent.height * 0.025
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: signupBtnClicked()

        background: Rectangle {
            radius: login.height * 0.02
            opacity: 0.75
            border.color: "#C0A8D8"
            border.width: 3
        }

        contentItem: Text {
            id: signupButtonText
            text: qsTr("Sign up")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Open Sans Regular"
            font.pixelSize: parent.width * 0.05
        }
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: trip
    title: qsTr("Trip")
    anchors.top: parent.top
    anchors.topMargin: parent.height * 0.1
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * 0.1

    property bool started: false
    property alias lapsedDValue: lapsedD.myValue
    property alias lapsedTValue: lapsedT.myValue
    property alias remainingDValue: remainingD.myValue
    property alias remainingTValue: remainingT.myValue

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    Detail {
        id: lapsedD
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.05
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.066
        myWidth: parent.width * 0.4
        myHeight: parent.height * 0.2
        myTitle: "Distance Covered"
        myValue: "-.- km"
        myColor: "#783090"
        myTextColor: "#ffffff"
    }

    Detail {
        id: lapsedT
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.05
        anchors.left: lapsedD.right
        anchors.leftMargin: parent.width * 0.067
        myWidth: parent.width * 0.4
        myHeight: parent.height * 0.2
        myTitle: "Time Lapsed"
        myValue: "--:--:--"
        myColor: "#f0d800"
        myTextColor: "#000000"
    }

    Detail {
        id: remainingD
        anchors.top: lapsedD.bottom
        anchors.topMargin: parent.height * 0.05
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.066
        myWidth: parent.width * 0.4
        myHeight: parent.height * 0.2
        myTitle: "Distance Remaining"
        myValue: "-.- km"
        myColor: "#ffffff"
        myTextColor: "#000000"
    }

    Detail {
        id: remainingT
        anchors.top: lapsedT.bottom
        anchors.topMargin: parent.height * 0.05
        anchors.left: remainingD.right
        anchors.leftMargin: parent.width * 0.067
        myWidth: parent.width * 0.4
        myHeight: parent.height * 0.2
        myTitle: "Time Remaining"
        myValue: "--:--:--"
        myColor: "#0090f0"
        myTextColor: "#ffffff"
    }

    Button {
        id: button
        visible: false
        anchors.bottomMargin: parent.height * 0.05
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle {
            implicitWidth: trip.width * 0.5
            implicitHeight: trip.height * 0.125
            color: "#d8c0d8"
            radius: trip.height * 0.02
        }

        contentItem: Text {
            id: buttonText
            text: qsTr("Start")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: trip.height * 0.05
            fontSizeMode: Text.Fit
            font.family: "Open Sans Regular"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

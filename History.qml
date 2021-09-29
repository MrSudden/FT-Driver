import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: history
    title: qsTr("History")
    anchors.top: parent.top
    anchors.topMargin: parent.height * 0.1
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * 0.1

    property bool started: false
    property color colorA: "#783090"
    property color colorB: "#f0d800"
    property color colorC: "#ffffff"
    property color colorD: "#0090f0"
    property alias modelA: modelA
    property alias emptyDelegate: emptyDelegate

    background: Rectangle {
        color: "#E6E6FA"
        opacity: 0.5
    }

    ListModel {
        id: modelA
        onLayoutChanged: listView.forceLayout()
    }

    Component {
        id: emptyDelegate

        Rectangle {
            id: delegate
            height: history.height
            width: history.width
            anchors.fill: parent
            visible: false

            Text {
                id: emptyText
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("No Trip History!")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.03
            }
        }
    }

    Component {
        id: deleg

        Rectangle {
            height: (history.height / 8) * 1.56
            width: history.width * 0.868
            color: (((1 % pos) === 0) || ((pos % 4) === 1)) ? colorA : (((2 % pos) === 0) || ((pos % 4) === 2)) ?  colorB : (((3 % pos) === 0) || ((pos % 4) === 3))  ? colorC : colorD
            anchors.horizontalCenter: parent.horizontalCenter
            radius: width * 0.05

            Text {
                id: tripId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.075
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(tripID)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.1
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: sourceId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: tripId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Source")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.075
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: sourceValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: sourceId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(source)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.125
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: destinationId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: sourceValue.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Destination")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.075
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: destinationValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: destinationId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(destination)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.125
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: departureId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: tripId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Departure")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.075
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: departureValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: departureId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(departure)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.07
                wrapMode: Text.WordWrap
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: arrivalId
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: departureValue.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Arrival")
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.075
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Text {
                id: arrivalValue
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top: arrivalId.bottom
                anchors.topMargin: parent.height * 0.044
                anchors.left: separator.right
                anchors.leftMargin: parent.width * 0.05
                text: qsTr(arrival)
                font.bold: Font.Bold
                font.family: "Open Sans Regular"
                font.pixelSize: parent.height * 0.07
                wrapMode: Text.WordWrap
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }

            Rectangle {
                id: separator
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: parent.height * 0.9
                implicitWidth: parent.height * 0.02
                radius: width * 0.5
                color: ((1 % pos) === 0) ? "#FFFFFF" : (((2 % pos) === 0) || ((pos % 4) === 2) || ((3 % pos) === 0) || ((pos % 4) === 3))  ? "#000000" : "#FFFFFF"
            }
        }
    }

    ListView {
        id: listView
        clip: true
        anchors.fill: parent
        anchors.topMargin: (history.height / 8) * 0.15
        model: modelA
        spacing: (history.height / 8) * 0.15
        delegate: deleg
    }
}

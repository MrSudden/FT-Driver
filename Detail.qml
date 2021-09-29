import QtQuick 2.12
import QtQuick.Controls 2.12

Pane {
    id: detail
//    property real myWidth: parent.width * 0.5
//    property real myHeight: parent.height * 0.5
    property real myWidth: 640
    property real myHeight: 480
    property string myTitle: "Dummy Dummy"
    property string myValue: "00:00:00"
    property color myColor: "#000000"
    property color myTextColor: "#ffffff"

    background: Rectangle {
        implicitWidth: myWidth
        implicitHeight: myHeight
//        border.color: "#ffffff"
//        border.width: myHeight * 0.0125
        color: myColor
        radius: myHeight * 0.1
    }

    contentItem: Item {
        id: column
        width: myWidth * 0.8
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: detailTitle
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: myHeight * 0.15
            text: qsTr(myTitle)
            color: myTextColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: myHeight * 0.1
            font.family: "Open Sans Regular"
            fontSizeMode: Text.HorizontalFit
        }

        Text {
            id: detailValue
            width: parent.width
            anchors.top: detailTitle.bottom
            anchors.topMargin: myHeight * 0.25
            text: qsTr(myValue)
            color: myTextColor
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: myHeight * 0.2
            font.family: "Open Sans Regular"
            fontSizeMode: Text.HorizontalFit
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

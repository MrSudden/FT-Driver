import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: splash
    anchors.fill: parent

    Image {
        id: logo
        source: "Futminna_BUS_MONITORING_2.png"
        width: parent.width * 0.6
        height: width
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
}

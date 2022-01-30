import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtPositioning 5.12
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("FT Driver")

    property string uid: "None"
    property Item lastItem: null

    background: Rectangle {
        color: "#FFFFFF"
    }

    TopTabPanel {
        id: topPanel
        visible: false
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        onAboutMAClicked: {
            lastItem = (stackView.currentItem == trip) ? trip : history
            stackView.push(about)
            about.visible = true
            topPanel.visible = false
            bottomPanel.visible = false
        }
        titleText: "Trip"
//        onProfileMAClicked: {
//            menu.visible = true
//            login.visible = false
//            signup.visible = false
//            trip.visible = false
//            history.visible = false
//        }
    }

    BottomPanelTwo {
        id: bottomPanel
        visible: false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onFirstTabMAClicked: {
            if(stackView.currentItem === trip) {
                null
            }
            else {
                stackView.clear()
                stackView.push(trip)
                trip.visible = true
                sel = "a"
                topPanel.titleText = "Trip"
            }
        }
        onSecondTabMAClicked: {
            if(stackView.currentItem === history) {
                null
            }
            else {
                stackView.clear()
                stackView.push(history)
                history.visible = true
                sel = "b"
                topPanel.titleText = "History"
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: {
            var authen = settings.value("authenticate", false)
            if (authen) {
                stackView.initialItem = trip
                splash.visible = false
                trip.visible = true
                topPanel.visible = true
                bottomPanel.visible = true
                console.log("Depth: ", stackView.depth)
            }
            else {
                stackView.initialItem = splash
                splashTimer.running = true
            }
        }
    }

    SplashScreen {
        id: splash
        visible: true
    }

    About {
        id: about
        visible: false
        onCloseMAClicked: {
            stackView.pop()
            visible = false
            topPanel.visible = true
            bottomPanel.visible = true
        }
    }

    History {
        id: history
        visible: false
    }

    Trip {
        id: trip
        visible: false
        start.visible: settings.value("transit", true)
        onStartBtnClicked: {
            backgroundTimer.running = true
            start.enabled = false
            start.visible = false
        }
    }

    Auth {
        id: auth
        visible: false
        onValidateBtnClicked: validateCom(authIdText, authKeyText)
    }

    Settings {
        id: settings
        property string authId: "None"
        property string authKey: "None"
        property bool authenticate: false
        property bool transit: false
    }

    PositionSource {
        id: pos
        preferredPositioningMethods: PositionSource.SatellitePositioningMethods
        updateInterval: 10000
        active: true
    }

    Timer {
        id: backgroundTimer
        interval: 30000
        running: false
        repeat: true
        onTriggered: myWorker.sendMessage({'msg': true})
    }

    Timer {
        id: splashTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            var authen = settings.value("authenticate", false)
            if (authen) {
                stackView.clear()
                stackView.push(trip)
                splash.visible = false
                topPanel.visible = true
                bottomPanel.visible = true
                trip.visible = true
            }
            else {
                stackView.clear()
                stackView.push(auth)
                splash.visible = false
                auth.visible = true
            }
        }
    }

    WorkerScript {
        id: myWorker
        source: "script.mjs"
        onMessage: {
            if (backgroundTimer.running)
                pos.update()
                api(String(pos.position.coordinate.latitude), String(pos.position.coordinate.longitude), String(pos.position.speed), settings.name)
        }
    }

    function validateCom(par, key){
        request('http://dcraz8317.pythonanywhere.com/auth?uid='+par+'&key='+key, function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                settings.authId = myJsonObject.id
                settings.authKey = myJsonObject.key
                settings.authenticate = myJsonObject.authenticate
                settings.setValue("Auth ID", settings.authId)
                settings.setValue("Auth KEY", settings.authKey)
                settings.setValue("authenticate", settings.authenticate)
                auth.visible = false
                stackView.push(trip)
                trip.visible = true
                topPanel.visible = true
                bottomPanel.visible = true
            }
        });
    }

    function api(par, val, pas, uid) {
        request('http://dcraz8317.pythonanywhere.com/api?lat='+par+'&lng='+val+'&spd='+pas+'&id='+uid, function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            var timeUnit = "secs"
            if (!myJsonObject.status) {
                history.modelA.clear()
                trip.lapsedDValue = "-.-"
                trip.remainingDValue = "-.-"
                trip.lapsedTValue = "--:--"
                trip.remainingTValue = "--:--"
                for (var i = 0; i < myJsonObject.trip.length; i++) {
                    history.modelA.append({"tripID": String(myJsonObject.trip[i]["pos"]), "destination": myJsonObject.trip[i]["destination"], "source": myJsonObject.trip[i]["source"], "pos": myJsonObject.trip[i]["pos"], "departure": myJsonObject.trip[i]["departure"], "arrival": myJsonObject.trip[i]["arrival"]})
                }
                history.modelA.layoutChanged()
                if (!myJsonObject.transit) {
                    backgroundTimer.running = false
                    trip.start.enabled = true
                    trip.start.visible = true
                    settings.setValue("transit", true)
                }
                else {
                    settings.setValue("transit", false)
                }
            }
            if (myJsonObject.status) {
                history.modelA.clear()
                var lapsedTUnit = "mins"
                var remainingTUnit = "mins"
                if ((myJsonObject.timeL / 60) <= 0) {
                    lapsedTUnit = "secs"
                }
                if ((myJsonObject.time / 60) <= 0) {
                    remainingTUnit = "secs"
                }
                trip.lapsedDValue = String(formatSeconds(Math.floor(myJsonObject.distanceL / 1000))) + "." + String(formatSeconds(myJsonObject.distanceL % 1000)) + String(" km")
                trip.remainingDValue = String(formatSeconds(Math.floor(myJsonObject.distance / 1000))) + "." + String(formatSeconds(myJsonObject.distance % 1000)) + String(" km")
                trip.lapsedTValue = String(formatSeconds(Math.floor(myJsonObject.timeL / 60))) + String(":") + String(formatSeconds(myJsonObject.timeL)) + String(" ") + String(lapsedTUnit)
                trip.remainingTValue = String(formatSeconds(Math.floor(myJsonObject.time / 60))) + String(":") + String(formatSeconds(myJsonObject.time)) + String(" ") + String(remainingTUnit)
                for (var l = 0; l < myJsonObject.trip.length; l++) {
                    history.modelA.append({"tripID": String(myJsonObject.trip[l]["pos"]), "destination": myJsonObject.trip[l]["destination"], "source": myJsonObject.trip[l]["source"], "pos": myJsonObject.trip[l]["pos"], "departure": myJsonObject.trip[l]["departure"], "arrival": myJsonObject.trip[l]["arrival"]})
                }
                history.modelA.layoutChanged()
                if (!myJsonObject.transit) {
                    backgroundTimer.running = false
                    trip.start.enabled = true
                    trip.start.visible = true
                    settings.setValue("transit", true)
                }
                else {
                    settings.setValue("transit", false)
                }
            }
        });
    }

    function getTimes(val) {
        var ti = new Date()
        ti.setSeconds(ti.getSeconds() + val)
        return String(formatSeconds(ti.getHours())) + String(":") + String(formatSeconds(ti.getMinutes())) + String(":") + String(formatSeconds(ti.getSeconds()))
    }

    function formatSeconds(val) {
        var decis = ""
        if (val < 10) {
            decis = String("0" + String(val))
        }
        else {
            decis = String(val)
        }
        return decis
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                if (myxhr.readyState === 4)
                    callback(myxhr);
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }
}

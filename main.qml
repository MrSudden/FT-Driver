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

    property string uid: "FTD"
    property Item lastItem: trip

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
                stackView.pop()
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
                stackView.pop()
                stackView.push(history)
                history.visible = true
                sel = "b"
                topPanel.titleText = "History"
            }
        }
    }

    StackView {
        id: stackView
        initialItem: splash
        anchors.fill: parent
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

    Signup {
        id: signup
        visible: false
        onLoginBtnClicked: {
            stackView.pop()
            visible = false
            login.visible = true
        }
        onSignupBtnClicked: {
            signupCom(nameText, emailText, passwordText)
        }
    }

    History {
        id: history
        visible: false
    }

    Trip {
        id: trip
        visible: false
    }

    Login {
        id: login
        visible: false
        onLoginBtnClicked: {
            loginCom(emailText, passwordText)
        }
        onSignupBtnClicked: {
            if (stackView.depth === 1) {
                stackView.push(signup)
                visible = true
                login.visible = false
            }
        }
    }

    Settings {
        id: settings
        property string name: "None"
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
        interval: 5000
        running: true
        repeat: false
        onTriggered: {
            stackView.replace(splash, login)
            stackView.pop(splash)
            splash.visible = false
            login.visible = true
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

    function loginCom(par, val) {
        request('http://dcraz8317.pythonanywhere.com/login?email='+par+'&password='+val+'&type=driver', function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                stackView.replace(login, trip)
                stackView.pop(login)
                stackView.initialItem = trip
                login.visible = false
                trip.visible = true
                topPanel.visible = true
                bottomPanel.visible = true
                backgroundTimer.running = true
            }
        });
    }

    function signupCom(par, val, pas) {
        request('http://dcraz8317.pythonanywhere.com/signupd?name='+par+'&email='+val+'&password='+pas, function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                settings.name = myJsonObject.id
                signup.visible = false
                stackView.pop()
                login.visible = true
                trip.visible = false
                topPanel.visible = false
                bottomPanel.visible = false
            }
        });
    }

    function api(par, val, pas, uid) {
        request('http://dcraz8317.pythonanywhere.com/api?lat='+par+'&lng='+val+'&spd='+pas+'&id='+uid, function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (!myJsonObject.status) {
                history.modelA.clear()
                trip.lapsedDValue = "-.- km"
                trip.remainingDValue = "-.- km"
                trip.lapsedTValue = "--:--"
                trip.remainingTValue = "--:--"
                for (var i = 0; i < myJsonObject.trip.length; i++) {
                    history.modelA.append({"tripID": String(myJsonObject.trip[i]["pos"]), "destination": myJsonObject.trip[i]["destination"], "source": myJsonObject.trip[i]["source"], "pos": myJsonObject.trip[i]["pos"], "departure": myJsonObject.trip[i]["departure"], "arrival": myJsonObject.trip[i]["arrival"]})
                }
                history.modelA.layoutChanged()
            }
            if (myJsonObject.status) {
                history.modelA.clear()
                trip.lapsedDValue = String(formatSeconds(Math.floor(myJsonObject.distanceL / 1000))) + "." + String(formatSeconds(myJsonObject.distanceL % 1000)) + String(" km")
                trip.remainingDValue = String(formatSeconds(Math.floor(myJsonObject.distance / 1000))) + "." + String(formatSeconds(myJsonObject.distance % 1000)) + String(" km")
                trip.lapsedTValue = String(formatSeconds(Math.floor(myJsonObject.timeL / 60))) + String(":") + String(formatSeconds(myJsonObject.timeL))
                trip.remainingTValue = String(formatSeconds(Math.floor(myJsonObject.time / 60))) + String(":") + String(formatSeconds(myJsonObject.time))
                for (var l = 0; l < myJsonObject.trip.length; l++) {
                    history.modelA.append({"tripID": String(myJsonObject.trip[l]["pos"]), "destination": myJsonObject.trip[l]["destination"], "source": myJsonObject.trip[l]["source"], "pos": myJsonObject.trip[l]["pos"], "departure": myJsonObject.trip[l]["departure"], "arrival": myJsonObject.trip[l]["arrival"]})
                }
                history.modelA.layoutChanged()
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

    Component.onCompleted: {
        uid = settings.name
    }
}

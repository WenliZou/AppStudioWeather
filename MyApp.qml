﻿/* Copyright 2018 Esri
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */


// You can run your app in Qt Creator by pressing Alt+Shift+R.
// Alternatively, you can run apps through UI using Tools > External > AppStudio > Run.
// AppStudio users frequently use the Ctrl+A and Ctrl+I commands to
// automatically indent the entirety of the .qml file.


import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0

App{
    id: app
    width: 421
    height: 750

    property bool lightTheme: true

    // App color properties

    readonly property color appBackgroundColor: lightTheme? "#FAFAFA":"#303030"
    readonly property color appDialogColor: lightTheme? "#FFFFFF":"424242"
    readonly property color appPrimaryTextColor: lightTheme? "#000000":"#FFFFFF"
    readonly property color appSecondaryTextColor: Qt.darker(appPrimaryTextColor)
    readonly property color primaryColor:"#2297F5"
    readonly property color accentColor: Qt.lighter(primaryColor,1.2)
    readonly property color headerTextColor:"#FFFFFF"
    readonly property color listViewDividerColor:"#19000000"

    // App size properties

    property real scaleFactor: AppFramework.displayScaleFactor
    readonly property real baseFontSize: app.width<450*app.scaleFactor? 21 * scaleFactor:23 * scaleFactor
    readonly property real titleFontSize: 1.1 * app.baseFontSize
    readonly property real captionFontSize: 0.6 * app.baseFontSize

    property var locationName:qsTr("Redlands, US")
    //Want to put it in a key-value pair in the future
    property var tempNow
    property var weatherNow
    property var tempMinNumberNow
    property var tempMaxNumberNow
    property var windSpeedNow
    property var pressureNumberNow
    property var humidityPercentNow
    property var sunriseTimeNow
    property var sunsetTimeNow
    property var dataCollectedTimeNow

    property var name: value


    Component.onCompleted: getWeather()

    function getWeather(){
        var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var responseJSON = JSON.parse(xhr.responseText)
                weatherNow = responseJSON.weather[0].main
                tempNow = responseJSON.main.temp
                locationName=responseJSON.name
                var ptDate = new Date(responseJSON.sys.sunrise*1000)
                sunriseTimeNow = ptDate.toLocaleString(Qt.locale("de_DE"), "HH:mm")
                var ptDate2 = new Date(responseJSON.sys.sunset*1000)
                sunsetTimeNow = ptDate2.toLocaleString(Qt.locale("de_DE"), "HH:mm")
                tempMinNumberNow = responseJSON.main.temp_min
                tempMaxNumberNow = responseJSON.main.temp_max
                windSpeedNow = responseJSON.wind.speed
                pressureNumberNow = responseJSON.main.pressure
                humidityPercentNow = responseJSON.main.humidity
                var ptDate3 = new Date(responseJSON.dt*1000)
                dataCollectedTimeNow =ptDate.toLocaleString(Qt.locale("de_DE"), "yyyy-MM-dd HH:mm:ss")
            }
        }

        // Define the target of your request
        xhr.open("GET", "http://api.openweathermap.org/data/2.5/weather?q=Redlands,us&&units=imperial&APPID=52235241a93c5deb2028c99639c90403")
        // Execute the request
        xhr.send()
        return tempNow
    }

    Loader{
        id: loader
        anchors.fill: parent
        sourceComponent:page1ViewPage
    }

    ListModel{
        id: tabViewModel
        ListElement { name: qsTr("TODAY"); }
        ListElement { name: qsTr("TOMORROW"); }
        ListElement { name: qsTr("LATER"); }
        ListElement { name: qsTr("TWEETS"); }
    }
    Component{
        id: page1ViewPage
        AddressPage{
            descText: locationName
            temperatureNumber: Math.round(tempNow)
            sunriseTime: sunriseTimeNow
            sunsetTime: sunsetTimeNow
            weatherinfoStc: weatherNow
            tempMinNumber:tempMinNumberNow
            tempMaxNumber:tempMaxNumberNow
            windSpeed: windSpeedNow
            pressureNumber: pressureNumberNow
            humidityPercent: humidityPercentNow
            dataCollectedTime: dataCollectedTimeNow
        }
    }
    Component{
        id: todayView
        ContentPage{
            descText: qsTr("Today")
        }
    }
    Component{
        id: tomorrowView
        ContentPage{
            descText: qsTr("Tomorrow")
        }
    }
    Component{
        id: laterView
        ContentPage{
            descText: qsTr("Later")
        }
    }
    Component{
        id: tweetView
        ContentPage{
            descText: qsTr("Tweet")
        }
    }
}







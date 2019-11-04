import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import ArcGIS.AppFramework 1.0


Page {
    id: content
    anchors.fill: parent
    property var descText
    property var listModelName

    property var tempForecast
    property var weatherForecast
    property var timeForecast
    property var windSpeedForecast
    property var pressureNumberForecast
    property var humidityPercentForecast
    property var weatherIconSourceForecast
    property var timetest
    property var tomorrowtest

    readonly property string weatherIconSourceUrl: "http://openweathermap.org/img/w/"

    property var urlHead:"http://api.openweathermap.org/data/2.5/"
    property var urlType:"weather?q="
    property var urlForecast:"forecast?q="
    property var urlCity:"Redlands"
    property var urlTail:"&units=imperial&APPID=52235241a93c5deb2028c99639c90403"


    ListView{
        id:weatherList
        delegate: weatherItem
        anchors.top:test.bottom;
        width: parent.width
        height: parent.height
        Component.onCompleted: {
            navigateToModel(listModelName);
        }
    }

    ListModel{
        id: weatherData1
        ListElement { weathertype: "sun";
        }

    }

    ListModel{
        id: weatherData2
        ListElement { weathertype: "rain"; }
    }

    ListModel{
        id: weatherData3

        ListElement { weathertype: "wind"; }
    }

    Component{
        id:weatherItem
        Rectangle{
            width: parent.width
            height: 120
            Rectangle{
                id:weatherName
                width:parent.width/2
                height: 120
                Column{
                    x:5
                    y:5
                    Text {
                        leftPadding: 20
                        id: time
                        text: "3:00 ~ 6:00"
                        opacity:0.6
                        font.pixelSize:app.baseFontSize*0.5
                    }
                    Text {
                        leftPadding: 20
                        id: name
                        anchors.top:time.bottom
                        text: weathertype
                        font.pixelSize:app.baseFontSize*0.9
                        font.bold: true
                    }
                    Label{
                        id:temp
                        leftPadding: 20
                        topPadding: 5
                        anchors.top:name.bottom
                        font.pixelSize: app.baseFontSize*0.7
                        wrapMode: Text.Wrap
                        text: "3"+" °F"
                    }
                    Label{
                        id:wind
                        leftPadding: 20
                        topPadding: 2
                        opacity:0.5
                        anchors.top:temp.bottom
                        font.pixelSize: app.baseFontSize*0.5
                        wrapMode: Text.Wrap
                        text: "Wind: "+"3"+" miles/s"
                    }
                    Label{
                        id:pressure
                        leftPadding: 20
                        topPadding: 2
                        opacity:0.5
                        anchors.top:wind.bottom
                        font.pixelSize: app.baseFontSize*0.5
                        wrapMode: Text.Wrap
                        text: "Pressure: "+"1000"+" hPa"
                    }
                    Label{
                        id:humidity
                        leftPadding: 20
                        topPadding: 2
                        opacity:0.5
                        anchors.top:pressure.bottom
                        font.pixelSize: app.baseFontSize*0.5
                        wrapMode: Text.Wrap
                        text: "Humidity: "+"20"+" %"
                    }
                }
            }

            Rectangle{
                anchors.left:weatherName.right
                width: parent.width/2
                height: 100
                Image{
                    width: 50
                    height:50
                    anchors.right:parent.right
                    anchors.rightMargin:50
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Qt.AlignVCenter
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/rain_black.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
            }
        }
    }

    function getForecastWeather(){
        var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var responseJSON = JSON.parse(xhr.responseText)
                for(var i in responseJSON.list){
                    var e = responseJSON.list[i]
                    weatherForecast = e.weather[0].main
                    console.log(weatherForecast)
                    tempForecast = e.main.temp
                    windSpeedForecast = e.wind.speed
                    pressureNumberForecast = e.main.pressure
                    humidityPercentForecast = e.main.humidity
                    weatherIconSourceForecast= e.weather[0].icon
                    timeForecast = e.dt_txt
                    if(timeForecast.split(" ")[0]==timetest.split(" ")[0]){
                        console.log("1")
                        //                        weatherData1.append({"weathertype":weatherForecast})

                        weatherData1.append({weathertype:"sun"})

                    } else if(timeForecast.split(" ")[0]==tomorrowtest){
                        console.log("2")
                        //                        weatherData2.append({"weathertype":weatherForecast})
                        weatherData1.append({weathertype:"rain"})

                    }else{
                        console.log("3")
                        weatherData3.append({weathertype:"windy"})
                    }
                }
            }
        }
        xhr.open("GET",urlHead+urlForecast+urlCity+urlTail)
        xhr.send()
    }

    function navigateToModel(listModelName){
        switch(listModelName){
        case "weatherData1":
            weatherList.model=weatherData1;
            break;
        case "weatherData2":
            weatherList.model=weatherData2;
            break;
        case "weatherData3":
            weatherList.model=weatherData3;
            break;
        default:
            break;
        }

    }






}

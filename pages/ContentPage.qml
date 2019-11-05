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

    property var todaytext: new Date().toLocaleString(Qt.locale("de_DE"), "yyyy-MM-dd");
    property var todayTime: new Date().getTime()
    property var tomorrowTimetest: todayTime+86400000
    property var tomorrowtext:new Date(tomorrowTimetest).toLocaleString(Qt.locale("de_DE"), "yyyy-MM-dd");

    property var weatherToday
    property var weatherIconSourceToday
    property var tempToday
    property var windToday
    property var pressureToday
    property var humidityToday

    readonly property string weatherIconSourceUrl: "http://openweathermap.org/img/w/"

    property var urlHead:"http://api.openweathermap.org/data/2.5/"
    property var urlType:"weather?q="
    property var urlForecast:"forecast?q="
    property var urlCity:"Redlands"
    property var urlTail:"&units=imperial&APPID=52235241a93c5deb2028c99639c90403"

    property string consumerKey : "stCqupbbkTOKbqZLjDIYUB9qO"
    property string consumerSecret : "4L2f8EBw2mSmSLZrIvV6YEDge75UU8nn3JQmVPpsXQYzNNqpPO"
    property string bearerToken : ""

    property var tweetTime
    property var tweetName
    property var tweetText

    ListView{
        id:weatherList
        delegate: listModelName=="tweetModel"?tweetItem:weatherItem
        //        delegate: weatherItem
        anchors.top:test.bottom;
        width: parent.width
        height: parent.height
        Component.onCompleted: {

            //            tweetSearch();
            navigateToModel(listModelName);
            getForecastWeather();

        }
    }

    ListModel{
        id: weatherData1
    }

    ListModel{
        id: weatherData2
    }

    ListModel{
        id: weatherData3
    }

    ListModel{
        id: tweetModel
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
                y:5
                Text {
                    leftPadding: 20
                    id: time
                    text: timeToday > ""? timeToday:""
                    opacity:0.6
                    font.pixelSize:app.baseFontSize*0.5
                }
                Text {
                    leftPadding: 20
                    id: name
                    anchors.top:time.bottom
                    text: weatherType > ""? weatherType:""
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
                    text:tempType > ""? tempType+" °F":""
                }
                Label{
                    id:wind
                    leftPadding: 20
                    topPadding: 2
                    opacity:0.5
                    anchors.top:temp.bottom
                    font.pixelSize: app.baseFontSize*0.5
                    wrapMode: Text.Wrap
                    text: windType > ""? "Wind: " +windType+" miles/s":""
                }
                Label{
                    id:pressure
                    leftPadding: 20
                    topPadding: 2
                    opacity:0.5
                    anchors.top:wind.bottom
                    font.pixelSize: app.baseFontSize*0.5
                    wrapMode: Text.Wrap
                    text: pressureTypes > ""? "Pressure: " +pressureTypes+" hpa":""
                }
                Label{
                    id:humidity
                    leftPadding: 20
                    topPadding: 2
                    opacity:0.5
                    anchors.top:pressure.bottom
                    font.pixelSize: app.baseFontSize*0.5
                    wrapMode: Text.Wrap
                    text: humidityType > ""? "Humidity: " +humidityType+" %":""
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
                    source:weatherIconSourceType
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
            }
        }
    }

    Component{
        id:tweetItem
        Rectangle{
            width: parent.width
            height: 140
            Rectangle{
                id:weatherName
                width:parent.width
                height: 120
                Text {
                    anchors.top:testbutton.bottom
                    topPadding: 20
                    leftPadding: 20
                    id: time
                    text: tweetTime > ""? tweetTime:" "
                    opacity:0.6
                    font.pixelSize:app.baseFontSize*0.5
                }
                Text {
                    topPadding: 5
                    leftPadding: 20
                    id: name
                    anchors.top:time.bottom
                    text: tweetName > ""? tweetName:" "
                    font.pixelSize:app.baseFontSize*0.9
                    font.bold: true
                }
                Text{
                    id:temp
                    leftPadding: 20
                    topPadding: 5
                    width:parent.width
                    anchors.top:name.bottom
                    font.pixelSize: app.baseFontSize*0.7
                    wrapMode: Text.WordWrap
                    Layout.preferredWidth: application_window.width
                    text:tweetText> ""? tweetText:" "
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
                    //                    console.log(weatherForecast)
                    tempForecast = e.main.temp
                    windSpeedForecast = e.wind.speed
                    pressureNumberForecast = e.main.pressure
                    humidityPercentForecast = e.main.humidity
                    weatherIconSourceForecast= weatherIconSourceUrl+e.weather[0].icon+ ".png"
                    timeForecast = e.dt_txt
                    if(timeForecast.split(" ")[0]==todaytext){
                        weatherData1.append(
                                    {timeToday:timeForecast,
                                        weatherType: weatherForecast,
                                        weatherIconSourceType:weatherIconSourceForecast,
                                        tempType:tempForecast,
                                        windType:windSpeedForecast,
                                        pressureTypes:pressureNumberForecast,
                                        humidityType:humidityPercentForecast})

                    } else if(timeForecast.split(" ")[0]==tomorrowtext){
                        weatherData2.append(
                                    {timeToday:timeForecast,
                                        weatherType: weatherForecast,
                                        weatherIconSourceType:weatherIconSourceForecast,
                                        tempType:tempForecast,
                                        windType:windSpeedForecast,
                                        pressureTypes:pressureNumberForecast,
                                        humidityType:humidityPercentForecast})

                    }else{
                        weatherData3.append(
                                    {timeToday:timeForecast,
                                        weatherType: weatherForecast,
                                        weatherIconSourceType:weatherIconSourceForecast,
                                        tempType:tempForecast,
                                        windType:windSpeedForecast,
                                        pressureTypes:pressureNumberForecast,
                                        humidityType:humidityPercentForecast})
                    }
                }
            }
        }
        xhr.open("GET",urlHead+urlForecast+urlCity+urlTail)
        xhr.send()
    }
    function appendWeather1(){
        weatherData1.append({
                                timeToday:" ",
                                weatherType: weatherToday,
                                weatherIconSourceType:weatherIconSourceToday,
                                tempType:tempToday,
                                windType:windToday,
                                pressureTypes:pressureToday,
                                humidityType:humidityToday
                            });
    }



    function navigateToModel(listModelName){
        switch(listModelName){
        case "weatherData1":
            weatherList.model=weatherData1;
            appendWeather1();
            break;
        case "weatherData2":
            weatherList.model=weatherData2;
            break;
        case "weatherData3":
            weatherList.model=weatherData3;
            break;
        case "tweetModel":
            weatherList.model=tweetModel;
            load();
            break;
        default:
            break;
        }

    }


    function load() {
        //        tweets.clear()

        var req = new XMLHttpRequest;
        req.open("GET", "https://api.twitter.com/1.1/search/tweets.json?q=%23weather&result_type=recent");
        req.setRequestHeader("Authorization", "Bearer " + bearerToken);
        req.onload = function() {
            var objectArray = JSON.parse(req.responseText);
            if (objectArray.errors !== undefined) {
                console.log("Error fetching tweets: " + objectArray.errors[0].message)
            } else {
                for (var key in objectArray.statuses) {
                    var jsonObject = objectArray.statuses[key];
                    //                    tweets.append(jsonObject);
                    //                    console.log(jsonObject)
                    var tweetTimeTemp = jsonObject.created_at
                    var tweetNameTemp = jsonObject.user.screen_name
                    var tweetTextTemp = jsonObject.text
                    tweetModel.append({
                                          tweetTime:tweetTimeTemp,
                                          tweetName:tweetNameTemp,
                                          tweetText:tweetTextTemp
                                      })
                }
            }
        }
        req.send();
    }
}

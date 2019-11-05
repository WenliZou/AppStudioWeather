import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Esri.ArcGISRuntime.Toolkit.Controls 100.6
import Esri.ArcGISRuntime 100.6
import QtPositioning 5.6


Page {
    id: page
    signal next();
    property var descText
    property var temperatureNumber
    property var tempMinNumber
    property var tempMaxNumber
    property var weatherinfoStc
    property var windSpeed
    property var pressureNumber
    property var humidityPercent
    property var sunriseTime
    property var sunsetTime
    property var dataCollectedTime
    property var weatherIconSourcePic
    header: ToolBar{
        contentHeight: 56*app.scaleFactor
        Material.primary: app.primaryColor
        background: Rectangle {
            implicitHeight: 40
            color: app.primaryColor
            Rectangle {
                width: parent.width
                anchors.bottom: parent.bottom
                color: "transparent"
            }
        }
        RowLayout {
            anchors.fill: parent
            spacing: 0
            Item{
                Layout.preferredWidth: 16*app.scaleFactor
                Layout.fillHeight: true
            }
            ToolButton {
                id: locationButton
                text: descText > ""? descText:""
                font.pixelSize: app.titleFontSize
                anchors.left:parent.left
                anchors.leftMargin: 20
                contentItem: Text {
                    text: locationButton.text
                    font.pixelSize: locationButton.font.pixelSize
                    Layout.fillWidth: true
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: app.headerTextColor
                }
                onClicked: {
                    next();
                }
            }
            ToolButton {
                anchors.right:refreshButton.left
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/search.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked: {
                    console.log("Search");
                    searchCity.visible = !searchCity.visible;
                }
            }
            ToolButton {
                id: refreshButton
                anchors.right:moreButton.left
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/refresh.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true

                }
                onClicked: {
                    console.log(urlHead+urlType+urlCity+urlTail)
                    app.getWeather()
                }
            }
            ToolButton {
                id: moreButton
                anchors.right:parent.right
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/more.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked: {
                }
            }

        }
    }
    Rectangle{
        id:weather
        width: parent.width
        height: 250
        clip: true
        color: app.primaryColor
        anchors.leftMargin: 10
        Label{
            id:temperature
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: 1.5 * app.baseFontSize
            leftPadding: 20
            topPadding: 5
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: temperatureNumber > ""? temperatureNumber+"°F":""
        }
        Label{
            id:tempMinMax
            leftPadding: 20
            topPadding: 5
            anchors.top:temperature.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: (tempMinNumber > "" && tempMaxNumber> "")? tempMinNumber+"°F ~ "+tempMaxNumber+"°F":""
        }
        Label{
            id:weatherInfo
            leftPadding: 20
            topPadding: 5
            anchors.top:tempMinMax.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.baseFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: weatherinfoStc > ""? weatherinfoStc:""
        }
        Label{
            id:wind
            leftPadding: 20
            topPadding: 15
            anchors.top: weatherInfo.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: windSpeed > ""? "Wind: " +windSpeed+" miles/s":""
        }
        Label{
            id:pressure
            leftPadding: 20
            topPadding: 5
            anchors.top: wind.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: pressureNumber > ""? "Pressure: " +pressureNumber+" hpa":""
        }
        Label{
            id:humidity
            leftPadding: 20
            topPadding: 5
            anchors.top:pressure.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: humidityPercent > ""? "Humidity: " +humidityPercent+" %":""
        }
        Label{
            id:sunrise
            leftPadding: 20
            topPadding: 5
            anchors.top:humidity.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: sunriseTime > ""? "Sunrise: "+sunriseTime:""
        }
        Label{
            id:sunset
            leftPadding: 20
            topPadding: 5
            anchors.top:sunrise.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: sunsetTime > ""? "Sunset: "+sunsetTime:""
        }
        Image{
            id:weatherIcon
            width: parent.width*0.3
            height: parent.height*0.3
            anchors.right:parent.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Qt.AlignVCenter
            verticalAlignment: Qt.AlignVCenter
            //            source: "./assets/rain.png"
            source:weatherIconSourcePic
            fillMode: Image.PreserveAspectFit
            mipmap: true
        }
        Label{
            id:lastUpdateTime
            rightPadding: 35
            topPadding: 15
            anchors.top: weatherIcon.bottom
            anchors.right:parent.right
            horizontalAlignment: Qt.AlignRight
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.5
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: dataCollectedTime > ""? "Last Update: \n"+dataCollectedTime:""
        }
    }
    TabBar {
        id:dateSelect
        anchors.top:weather.bottom
        width: parent.width
        Material.background: app.primaryColor
        Material.accent: app.headerTextColor
        padding: 0
        Repeater {
            model: tabViewModel
            TabButton {
                id:middleTab
                text: name
                font.bold: true
                opacity: enabled ? 1.0 : 0.3
                contentItem: Text{
                    font: middleTab.font
                    text: "<font color='#fefefe'>" + middleTab.text + "</font>"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        onCurrentIndexChanged: {
            navigateToPage(currentIndex);
        }
    }
    Loader{
        id: date_loader
        anchors.top:dateSelect.bottom;
        height: parent.height-280-dateSelect.height
        width:parent.width
    }
    Rectangle {
        id: searchCity
        opacity: 0.9
        width: 120
        height: 40
        anchors.rightMargin: 50
        color: "#f7f8fa"
        border {
            color: "#7B7C7D"
        }
        visible: false
        anchors.right: parent.right
        TextField {
            id:searchCityText
            leftPadding: 10
            placeholderText: "Enter a city"
            Component.onCompleted: {
                text ="Redlands";
            }
            onAccepted: {
                app.urlCity=searchCityText.text
                searchCity.visible=false
                getWeather()
            }
        }

    }



    function navigateToPage(index){
        switch(index){
        case 0:
            date_loader.sourceComponent = todayView;
            break;
        case 1:
            date_loader.sourceComponent = tomorrowView;
            break;
        case 2:
            date_loader.sourceComponent = laterView;
            break;
        case 3:
            date_loader.sourceComponent = tweetView;
            break;
        default:
            break;
        }

    }
}

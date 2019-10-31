import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    id: page
    property var descText
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
            Label {
                Layout.fillWidth: true
                text: descText > ""? descText:""
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                font.pixelSize: app.titleFontSize
                color: app.headerTextColor
            }
            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "./assets/search.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked: {
                    console.log("Search");
                }
            }
            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "./assets/refresh.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true

                }
                onClicked: {
                    console.log("Refresh");
                }
            }
            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "./assets/more.png"
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
            text: "4.7°C"
        }

        Label{
            id:weatherInfo
            leftPadding: 20
            topPadding: 5
            anchors.top:temperature.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.baseFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: "Light Intensity shower rain"
        }
        Label{
            id:wind
            leftPadding: 20
            topPadding: 7
            anchors.top: weatherInfo.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: "Wind: 4.6 m/s "
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
            text: "Pressure: 1000.0 hPa"
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
            text: "Humidity: 100%"
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
            text: "Sunrise: 08:52"
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
            text: "Sunset: 17:32"
        }
        Label{
            id:uvIndex
            leftPadding: 20
            topPadding: 5
            anchors.top:sunset.bottom
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            font.pixelSize: app.titleFontSize*0.7
            wrapMode: Text.Wrap
            color: app.headerTextColor
            text: "UV Index: Low"
        }
        Image{
            width: parent.width*0.3
            height: parent.height*0.3
            anchors.right:parent.right
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Qt.AlignVCenter
            verticalAlignment: Qt.AlignVCenter
            source: "./assets/rain.png"
            fillMode: Image.PreserveAspectFit
            mipmap: true
            }
    }
     TabBar {
         id:dateSelect
         anchors.top:weather.bottom;
         width: parent.width
         Material.background: app.primaryColor
         Material.accent: app.headerTextColor
         padding: 0
         Repeater {
                model: tabViewModel
                TabButton {
                   text: name
                   font.bold: true
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

     function navigateToPage(index){
         switch(index){
         case 0:
             date_loader.sourceComponent = todayView;
             break;
         case 1:
             date_loader.sourceComponent = tomorrowView;
             break;
         case 2:
             date_loader.sourceComponent = laterView;;
             break;
         default:
             break;
         }

     }
}

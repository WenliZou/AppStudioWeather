import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import ArcGIS.AppFramework 1.0


Page {
    id: content
    anchors.fill: parent
    property var descText


    ListView{
        id:weatherList
        model: weatherData
        delegate: weatherItem
        anchors.top:test.bottom;
        width: parent.width
        height: parent.height
    }

    ListModel{
        id: weatherData
        ListElement { weathertype: qsTr("sun"); }
        ListElement { weathertype: qsTr("rain"); }
        ListElement { weathertype: qsTr("wind"); }
    }

    Rectangle{
        id:test
        width: parent.width
        height: 50
        clip: true
        color:"#ffffff"
        Label{
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            anchors.centerIn: parent
            font.pixelSize: app.titleFontSize
            font.bold: true
            wrapMode: Text.Wrap
            padding: 16*app.scaleFactor
            color: app.primaryColor
            text: descText > ""? descText:""
        }
    }

    Component{
        id:weatherItem
        Rectangle{
            width: parent.width
            height: 100
            Rectangle{
                id:weatherName
                width:parent.width/2
                height: 100
                Column{
                    x:5
                    y:5
                    Text {
                        id: name
                        text: weathertype
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
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Qt.AlignVCenter
                    verticalAlignment: Qt.AlignVCenter
                    source: "./assets/rain_black.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
            }
        }
    }




}

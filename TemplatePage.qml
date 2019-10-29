import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import ArcGIS.AppFramework 1.0

Page {
    id: page

    property var descText
    property string titleText: qsTr("Page Title")

    header: ToolBar{
        contentHeight: 56*app.scaleFactor
        Material.primary: app.primaryColor
        RowLayout {
            anchors.fill: parent
            spacing: 0
            Item{
                Layout.preferredWidth: 16*app.scaleFactor
                Layout.fillHeight: true
            }
            Label {
                Layout.fillWidth: true
                text: titleText
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
                    source: "./assets/more.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true

                }
                onClicked: {
                    optionsPanel.toggle()
                }
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        color: app.appBackgroundColor

        Label{
            Material.theme: app.lightTheme? Material.Light : Material.Dark
            anchors.centerIn: parent
            font.pixelSize: app.titleFontSize
            font.bold: true
            wrapMode: Text.Wrap
            padding: 16*app.scaleFactor
            text: descText > ""? descText:""
        }
    }

    TabBar {
        Material.background: app.appBackgroundColor
        Material.accent: app.accentColor
        padding: 0
        Repeater {
            model: tabViewModel
            TabButton {
                text: name
            }
        }
        onCurrentIndexChanged: {
            navigateToPage(currentIndex);
        }
    }

    Loader{
        id: loader
        anchors.fill: parent
    }

    
    OptionsMenuPanel{
        id:optionsPanel
        x: page.width-optionsPanel.width-8*app.scaleFactor
        y: page.y-36*app.scaleFactor
    }

}

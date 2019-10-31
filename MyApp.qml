/* Copyright 2018 Esri
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
<<<<<<< HEAD
    readonly property color primaryColor:"#2297F5"
=======
    readonly property color primaryColor:"#3F51B5"
>>>>>>> 1924d7ddd00119084db9529e89eb96b0e7550808
    readonly property color accentColor: Qt.lighter(primaryColor,1.2)
    readonly property color headerTextColor:"#FFFFFF"
    readonly property color listViewDividerColor:"#19000000"

    // App size properties

    property real scaleFactor: AppFramework.displayScaleFactor
    readonly property real baseFontSize: app.width<450*app.scaleFactor? 21 * scaleFactor:23 * scaleFactor
    readonly property real titleFontSize: 1.1 * app.baseFontSize
    readonly property real captionFontSize: 0.6 * app.baseFontSize


<<<<<<< HEAD
    Loader{
        id: loader
        anchors.fill: parent
        sourceComponent:page1ViewPage
=======
    MainPage{
        anchors.fill: parent
>>>>>>> 1924d7ddd00119084db9529e89eb96b0e7550808
    }

    ListModel{
        id: tabViewModel
<<<<<<< HEAD
        ListElement { name: qsTr("TODAY"); }
        ListElement { name: qsTr("TOMORROW"); }
        ListElement { name: qsTr("LATER"); }
    }
    Component{
        id: page1ViewPage
        AddressPage{
             descText: qsTr("London, GB")
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

=======
        ListElement { name: qsTr("Item 1"); }
        ListElement { name: qsTr("Item 2"); }
        ListElement { name: qsTr("Item 3"); }
        ListElement { name: qsTr("Item 4"); }
    }
    Component{
        id: page1ViewPage
        TemplatePage{
             descText: qsTr("Item 1")
        }
    }
    Component{
        id: page2ViewPage
        TemplatePage{
             descText: qsTr("Item 2")
        }
    }

    Component{
        id: page3ViewPage
        TemplatePage{
            descText: qsTr("Item 3")
        }
    }
    Component{
        id: page4ViewPage
        TemplatePage{
            descText: qsTr("Item 4")
        }
    }
>>>>>>> 1924d7ddd00119084db9529e89eb96b0e7550808
}







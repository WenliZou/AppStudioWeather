import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0
import Esri.ArcGISRuntime 100.2
import Esri.ArcGISRuntime.Toolkit.Controls 100.6


import QtPositioning 5.8
import QtSensors 5.3

Item {
    signal next();
    signal back();
    property var mapPageLocation
    property double lat
    property double lon
    // App Page
    Page{

        anchors.fill: parent
        // Adding App Page Header Section
        header: ToolBar{
            id:header
            contentHeight: 56 * app.scaleFactor
            Material.primary: app.primaryColor
            RowLayout{
                anchors.fill: parent
                spacing:0
                Item{
                    Layout.preferredWidth: 4*app.scaleFactor
                    Layout.fillHeight: true
                }
                ToolButton {
                    indicator: Image{
                        width: parent.width*0.5
                        height: parent.height*0.5
                        anchors.centerIn: parent
                        source: "./assets/back.png"
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                    }
                    onClicked:{
                        back();
                        // Go back previous page
                    }
                }
                Item{
                    Layout.preferredWidth: 20*app.scaleFactor
                    Layout.fillHeight: true
                }
                Label {
                    Layout.fillWidth: true
                    text: mapPageLocation > ""? mapPageLocation:""
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    font.pixelSize: app.titleFontSize
                    color: app.headerTextColor
                }
                ToolButton {
                    anchors.right:parent.right
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
            }
        }
        // Header Section ends

        // Page Body
        Rectangle{
            anchors.fill: parent
            MapView {

                id:mapView

                anchors.fill: parent
                property var viewPointCenter1
                property alias map: map
                property alias compass: compass
                Map{
                    id: map

                    BasemapTopographic{}
                    //                    initUrl: "http://melbournedev.maps.arcgis.com/home/webmap/viewer.html?webmap=c7bde7901f524071a8f56cf424a5a55a"
                    //                    BasemapImageryWithLabels {}
                    Component.onCompleted:{
                        console.log(lon)
                        console.log(lat)
                        mapView.zoomToSearchedlocation()
                    }
                }

                Compass {
                    id: compass

                    active: true
                }
                // Function to zoom to searched location by user. Smaller animation duration than zoomToPoint(point)
                function zoomToSearchedlocation(){
                    var currentPositionPoint = ArcGISRuntimeEnvironment.createObject("Point", {x: lon, y: lat, spatialReference: SpatialReference.createWgs84()});
                    console.log(currentPositionPoint)
                    var centerPoint = GeometryEngine.project(currentPositionPoint,  SpatialReference.createWgs84());
                    console.log(centerPoint.spatialReference)
                    var viewPointCenter = ArcGISRuntimeEnvironment.createObject("ViewpointCenter",{center: centerPoint, targetScale: 100000});
                    console.log(viewPointCenter.center.x)
                    viewPointCenter1 = viewPointCenter
                    mapView.setViewpointWithAnimationCurve(viewPointCenter, 1.0,  Enums.AnimationCurveEaseInOutCubic);
                }
            }
        }

    }
}


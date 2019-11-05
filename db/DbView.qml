import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0

import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0
import ArcGIS.AppFramework.Sql 1.0
import Esri.ArcGISRuntime.Toolkit.Controls 100.6
import Esri.ArcGISRuntime 100.6

item{

    FileFolder {
      id: fileFolder
      path: "~/ArcGIS/Data/Sql"
    }

    SqlDatabase {
      id: db
      databaseName: fileFolder.filePath("sample.sqlite")
    }

    Component.onCompleted: {
      fileFolder.makeFolder();
      db.open();
    }
}

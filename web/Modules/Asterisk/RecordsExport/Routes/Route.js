const RecordsExport = {
    data: { Name: `RecordsExport`, Small: ``} ,
    url         : "/RecordsExport",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RecordsExport/Views/All.html',
            controller  : 'RecordsExportCtrl'
        }
    }
};
const RecordsExportEdit = {
    data: { Name: `RecordsExport`, Small: ``} ,
    url         : "/RecordsExportEdit/{cbID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RecordsExport/Views/Edit.html',
            controller  : 'RecordsExportEditCtrl'
        }
    }
};
const RecordsExportNew = {
    data: { Name: `RecordsExport`, Small: ``} ,
    url         : "/RecordsExportNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RecordsExport/Views/New.html',
            controller  : 'RecordsExportNew'
        }
    }
};
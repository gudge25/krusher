const Record = {
    data: { Name: `recording`, Small: ``} ,
    url   : "/Record",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Record/Views/All.html',
            controller: 'RecordCtrl'
        }
    }
};
const RecordNew = {
    data: { Name: `recording`, Small: ``} ,
    url   : "/RecordNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Record/Views/New.html',
            controller: 'RecordNewCtrl'
        }
    }
};
const RecordEdit = {
    data: { Name: `recording`, Small: ``} ,
    url   : "/RecordEdit/{record_id:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Record/Views/Edit.html',
            controller: 'RecordEditCtrl'
        }
    }
};
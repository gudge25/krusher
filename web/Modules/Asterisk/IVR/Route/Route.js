const IVR = {
    data: { Name: `IVR`, Small: ``} ,
    url   : "/IVR",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/IVR/Views/All.html',
            controller: 'IVRCtrl'
        }
    }
};
const IVRNew = {
    data: { Name: `IVR`, Small: ``} ,
    url   : "/IVRNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/IVR/Views/New.html',
            controller: 'IVRNewCtrl'
        }
    }
};
const IVREdit = {
    data: { Name: `IVR`, Small: ``} ,
    url   : "/IVREdit/{id_IVR:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/IVR/Views/Edit.html',
            controller: 'IVREditCtrl'
        }
    }
};
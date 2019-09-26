const fs = {
    data: { Name: `files`, Small: ``} ,
    url         : "/fs",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Fs/Priority/Views/All.html',
            controller  : 'priorityCtrl'
        }
    }
};
const fsEdit = {
    data: { Name: `file`, Small: ``} ,
    url         : "/fsEdit/{ffID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Fs/Priority/Views/Edit.html',
            controller  : 'priorityEditCtrl'
        }
    }
};

const fsNew = {
    data: { Name: `file`, Small: ``} ,
    url         : "/fsNew",
    views : {
        "viewA" : {
            component  : 'fsnewctrl'
        }
    }
};
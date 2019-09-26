const Bases = {
    data: { Name: `categories`, Small: ``} ,
    url   : "/Bases",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Fs/Bases/Views/All.html',
            controller: 'fsBasesCtrl'
        }
    }
};
const BasesNew = {
    data: { Name: `category`, Small: ``} ,
    url   : "/BasesNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Fs/Bases/Views/New.html',
            controller: 'fsBasesNewCtrl'
        }
    }
};
const BasesEdit = {
    data: { Name: `category`, Small: ``} ,
    url   : "/BasesEdit/{dbID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Fs/Bases/Views/Edit.html',
            controller: 'fsBasesEditCtrl'
        }
    }
};
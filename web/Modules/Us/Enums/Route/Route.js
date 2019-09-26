const usEnums = {
    data: { Name: `Enums`, Small: ``} ,
    url   : "/Enums",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Enums/Views/All.html',
            controller: 'usEnumsCtrl'
        }
    }
};
const usEnumsNew = {
    data: { Name: `Enums`, Small: ``} ,
    url   : "/EnumsNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Enums/Views/New.html',
            controller: 'usEnumsNewCtrl'
        }
    }
};

const usEnumsNewID = {
    data: { Name: `Enums`, Small: ``} ,
    url   : "/EnumsNew/{tyID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Enums/Views/New.html',
            controller: 'usEnumsNewCtrl'
        }
    }
};

const usEnumsEdit = {
    data: { Name: `Enums`, Small: ``} ,
    url   : "/EnumsEdit/{tvID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Enums/Views/Edit.html',
            controller: 'usEnumsEditCtrl'
        }
    }
};
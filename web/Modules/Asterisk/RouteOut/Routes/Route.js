const RouteOut = {
    data: { Name: `RouteOut`, Small: ``} ,
    url         : "/RouteOut",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RouteOut/Views/All.html',
            controller  : 'RouteOutCtrl'
        }
    }
};
const RouteOutEdit = {
    data: { Name: `RouteOut`, Small: ``} ,
    url         : "/RouteOutEdit/{roID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RouteOut/Views/Edit.html',
            controller  : 'RouteOutEditCtrl'
        }
    }
};
const RouteOutNew = {
    data: { Name: `RouteOut`, Small: ``} ,
    url         : "/RouteOutNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/RouteOut/Views/New.html',
            controller  : 'RouteOutCtrlNew'
        }
    }
};
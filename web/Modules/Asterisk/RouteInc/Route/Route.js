const RouteInc = {
    data: { Name: `RouteInc`, Small: ``} ,
    url   : "/RouteInc",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/RouteInc/Views/All.html',
            controller: 'RouteIncCtrl'
        }
    }
};
const RouteIncNew = {
    data: { Name: `RouteInc`, Small: ``} ,
    url   : "/RouteIncNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/RouteInc/Views/New.html',
            controller: 'RouteIncNewCtrl'
        }
    }
};
const RouteIncEdit = {
    data: { Name: `RouteInc`, Small: ``} ,
    url   : "/RouteIncEdit/{rtID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/RouteInc/Views/Edit.html',
            controller: 'RouteIncEditCtrl'
        }
    }
};
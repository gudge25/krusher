const CustomDestination = {
    data: { Name: `CustomDestination`, Small: ``} ,
    url         : "/CustomDestination",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CustomDestination/Views/All.html',
            controller  : 'CustomDestinationCtrl'
        }
    }
};
const CustomDestinationEdit = {
    data: { Name: `CustomDestination`, Small: ``} ,
    url         : "/CustomDestinationEdit/:cdID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CustomDestination/Views/Edit.html',
            controller  : 'CustomDestinationEditCtrl'
        }
    }
};
const CustomDestinationNew = {
    data: { Name: `CustomDestination`, Small: ``} ,
    url         : "/CustomDestinationNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CustomDestination/Views/New.html',
            controller  : 'CustomDestinationNewCtrl'
        }
    }
};
const TrunkPool = {
    data: { Name: `TrunkPool`, Small: ``} ,
    url         : "/TrunkPool",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TrunkPool/Views/All.html',
            controller  : 'TrunkPoolCtrl'
        }
    }
};
const TrunkPoolEdit = {
    data: { Name: `TrunkPool`, Small: ``} ,
    url         : "/TrunkPoolEdit/{poolID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TrunkPool/Views/Edit.html',
            controller  : 'TrunkPoolEditCtrl'
        }
    }
};
const TrunkPoolNew = {
    data: { Name: `TrunkPool`, Small: ``} ,
    url         : "/TrunkPoolNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TrunkPool/Views/New.html',
            controller  : 'TrunkPoolNewCtrl'
        }
    }
};
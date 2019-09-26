const Conference = {
    data: { Name: `Conference`, Small: ``} ,
    url         : "/Conference",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/Conference/Views/All.html',
            controller  : 'ConferenceCtrl'
        }
    }
};
const ConferenceEdit = {
    data: { Name: `Conference`, Small: ``} ,
    url         : "/ConferenceEdit/:cfID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/Conference/Views/Edit.html',
            controller  : 'ConferenceEditCtrl'
        }
    }
};
const ConferenceNew = {
    data: { Name: `Conference`, Small: ``} ,
    url         : "/ConferenceNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/Conference/Views/New.html',
            controller  : 'ConferenceNewCtrl'
        }
    }
};
const TimeGroup = {
    data: { Name: `TimeGroup`, Small: ``} ,
    url         : "/TimeGroup",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TimeGroup/Views/All.html',
            controller  : 'TimeGroupCtrl'
        }
    }
};
const TimeGroupEdit = {
    data: { Name: `TimeGroup`, Small: ``} ,
    url         : "/TimeGroupEdit/{tgID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TimeGroup/Views/Edit.html',
            controller  : 'TimeGroupEditCtrl'
        }
    }
};
const TimeGroupNew = {
    data: { Name: `TimeGroup`, Small: ``} ,
    url         : "/TimeGroupNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/TimeGroup/Views/New.html',
            controller  : 'TimeGroupCtrlNew'
        }
    }
};
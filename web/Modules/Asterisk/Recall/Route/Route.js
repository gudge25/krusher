const Recall = {
    data: { Name: `Recalls`, Small: ``} ,
    url   : "/Recall",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Recall/Views/All.html',
            controller: 'RecallCtrl'
        }
    }
};
const RecallNew = {
    data: { Name: `Recalls`, Small: ``} ,
    url   : "/RecallNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Recall/Views/New.html',
            controller: 'RecallNewCtrl'
        }
    }
};
const RecallEdit = {
    data: { Name: `Recalls`, Small: ``} ,
    url   : "/RecallEdit/{rcID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Recall/Views/Edit.html',
            controller: 'RecallEditCtrl'
        }
    }
};
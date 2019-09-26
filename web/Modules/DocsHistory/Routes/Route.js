const DocsHistoryViewRoute = {
    url         : "/DocsHistory/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'DocsHistory/Views/All.html',
            controller  : 'DocsHistoryCtrl'
        }
    }
};
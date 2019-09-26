const Rank = {
    data: { Name: `Rank`, Small: ``} ,
    url   : "/Comments",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Rank/Views/All.html',
            controller: 'RankCtrl'
        }
    }
};
const RankNew = {
    data: { Name: `Rank`, Small: ``} ,
    url   : "/CommentsNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Rank/Views/New.html',
            controller: 'RankNewCtrl'
        }
    }
};
const RankEdit = {
    data: { Name: `Rank`, Small: ``} ,
    url   : "/CommentsEdit/{uID:[0-9]{1,30}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Rank/Views/Edit.html',
            controller: 'RankEditCtrl'
        }
    }
};
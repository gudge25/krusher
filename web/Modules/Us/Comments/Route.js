const Comments = {
    data: { Name: `comments`, Small: ``} ,
    url   : "/Comments",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Comments/Views/All.html',
            controller: 'CommentsCtrl'
        }
    }
};
const CommentsNew = {
    data: { Name: `comments`, Small: ``} ,
    url   : "/CommentsNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Comments/Views/New.html',
            controller: 'CommentsNewCtrl'
        }
    }
};
const CommentsEdit = {
    data: { Name: `comments`, Small: ``} ,
    url   : "/CommentsEdit/{uID:[0-9]{1,30}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Comments/Views/Edit.html',
            controller: 'CommentsEditCtrl'
        }
    }
};
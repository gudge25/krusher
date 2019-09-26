const commentlist = {
    data: { Name: `comments`, Small: ``} ,
    url   : "/commentlist",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Comment/Views/All.html',
            controller  : 'CommentListCtrl'
        }
    }
};

const CommentEdit = {
    data: { Name: `comment`, Small: ``} ,
    url   : "/CommentEdit/{comID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Comment/Views/Edit.html',
            controller  : 'CommentEditCtrl'
        }
    }
};
const TagList = {
    data: { Name: `tags`, Small: ``} ,
    url: "/TagList",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Tag/TagList/Views/All.html',
            controller: 'crmTagListCtrl'
        }
    }
};
const TagListEdit = {
    data: { Name: `tag`, Small: ``} ,
    url: "/TagListEdit/:tagID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Tag/TagList/Views/Edit.html',
            controller: 'crmTagListEditCtrl'
        }
    }
};
const TagListNew = {
    data: { Name: `tag`, Small: ``} ,
    url: "/TagListNew",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Tag/TagList/Views/New.html',
            controller: 'crmTagListNewCtrl'
        }
    }
};
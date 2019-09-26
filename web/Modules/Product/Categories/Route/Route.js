var Categories = {
    url   : "/Categories",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Categories/Views/All.html',
            controller: 'CategoriesCtrl'
        }
    }
};
var CategoriesNew = {
    url   : "/CategoriesNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Categories/Views/New.html',
            controller: 'CategoriesNewCtrl'
        }
    }
};
var CategoriesEdit = {
    url   : "/CategoriesEdit/{psID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Categories/Views/Edit.html',
            controller: 'CategoriesEditCtrl'
        }
    }
};
const Product = {
    url   : "/Product",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Product/Views/All.html',
            controller: 'ProductCtrl',
            resolve     : {
                            trans: ($translate,$translatePartialLoader) => { $translatePartialLoader.addPart(`${Gulp}Product/Product/Translate`); $translate.refresh(); }
            }
        }
    }
};
const ProductNew = {
    url   : "/ProductNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Product/Views/New.html',
            controller: 'ProductNewCtrl'
        }
    }
};
const ProductEdit = {
    url   : "/ProductEdit/{psID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Product/Views/Edit.html',
            controller: 'ProductEditCtrl',
            resolve     : {
                            trans: ($translate,$translatePartialLoader) => { $translatePartialLoader.addPart(`${Gulp}Product/Product/Translate`); $translate.refresh(); }
            }
        }
    }
};
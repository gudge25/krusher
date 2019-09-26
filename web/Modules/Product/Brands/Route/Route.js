var Brands = {
    url   : "/Brands",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Brands/Views/All.html',
            controller: 'BrandsCtrl'
        }
    }
};
var BrandsNew = {
    url   : "/BrandsNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Brands/Views/New.html',
            controller: 'BrandsNewCtrl'
        }
    }
};
var BrandsEdit = {
    url   : "/BrandsEdit/{bID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Product/Brands/Views/Edit.html',
            controller: 'BrandsEditCtrl'
        }
    }
};
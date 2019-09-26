const country = {
    url         : "/country",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Countries/Views/All.html',
            controller  : 'CountryCtrl'
        }
    }
};
const CountryNew = {
    url         : "/CountryNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Countries/Views/New.html',
            controller  : 'CountryNewCtrl'
        }
    }
};
const CountryEdit = {
    url         : "/CountryEdit/:cID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Countries/Views/Edit.html',
            controller  : 'CountryEditCtrl'
        }
    }
};
const Location = {
    url         : "/Location",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Locations/Views/All.html',
            controller  : 'LocationCtrl'
        }
    }
};
const LocationNew = {
    url         : "/LocationNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Locations/Views/New.html',
            controller  : 'LocationNewCtrl'
        }
    }
};
const LocationEdit = {
    url         : "/LocationEdit/:lID/:cID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Locations/Views/Edit.html',
            controller  : 'LocationEditCtrl'
        }
    }
};
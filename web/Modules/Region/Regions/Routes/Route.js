const Region = {
    url         : "/Region",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Regions/Views/All.html',
            controller  : 'RegionCtrl'
        }
    }
};
const RegionNew = {
    url         : "/RegionNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Regions/Views/New.html',
            controller  : 'RegionNewCtrl'
        }
    }
};
const RegionEdit = {
    url         : "/RegionEdit/:rgID/:cID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Regions/Views/Edit.html',
            controller  : 'RegionEditCtrl'
        }
    }
};
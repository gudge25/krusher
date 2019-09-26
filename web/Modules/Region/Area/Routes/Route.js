const Area = {
    url         : "/Area",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Area/Views/All.html',
            controller  : 'AreaCtrl'
        }
    }
};
const AreaNew = {
    url         : "/AreaNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Area/Views/New.html',
            controller  : 'AreaNewCtrl'
        }
    }
};
const AreaEdit = {
    url         : "/AreaEdit/:aID/:cID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Area/Views/Edit.html',
            controller  : 'AreaEditCtrl'
        }
    }
};
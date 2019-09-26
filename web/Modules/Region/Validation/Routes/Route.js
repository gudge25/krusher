const Validation = {
    url         : "/Validation",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Validation/Views/All.html',
            controller  : 'ValidationCtrl',
        }
    }
};
const ValidationEdit = {
    url         : "/ValidationEdit/:vID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Validation/Views/Edit.html',
            controller  : 'ValidationEditCtrl',
        }
    }
};
const ValidationNew = {
    url         : "/ValidationNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Validation/Views/New.html',
            controller  : 'ValidationNewCtrl',
        }
    }
};
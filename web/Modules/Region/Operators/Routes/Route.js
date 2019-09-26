const operator = {
    url         : "/operator",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Operators/Views/All.html',
            controller  : 'OperatorCtrl'
        }
    }
};
const OperatorNew = {
    url         : "/OperatorNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Operators/Views/New.html',
            controller  : 'OperatorNewCtrl'
        }
    }
};
const OperatorEdit = {
    url         : "/OperatorEdit/:oID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Region/Operators/Views/Edit.html',
            controller  : 'OperatorEditCtrl'
        }
    }
};
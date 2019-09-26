var Car = {
    url         : "/Car",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Car/Views/Car.html',
            controller  : 'CarCtrl'
        }
    }
};
var CarNew = {
    url         : "/CarNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Car/Views/CarNew.html',
            controller  : 'CarNewCtrl'
        }
    }
};
var CarEdit = {
    url         : "/CarEdit/:carID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Car/Views/CarEdit.html',
            controller  : 'CarEditCtrl'
        }
    }
};
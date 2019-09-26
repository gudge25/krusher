var Driver = {
    url         : "/Driver",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Driver/Views/Driver.html',
            controller  : 'DriverCtrl'
        }
    }
};
var DriverNew = {
    url         : "/DriverNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Driver/Views/DriverNew.html',
            controller  : 'DriverNewCtrl'
        }
    }
};
var DriverEdit = {
    url         : "/DriverEdit/:drvID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Driver/Views/DriverEdit.html',
            controller  : 'DriverEditCtrl'
        }
    }
};
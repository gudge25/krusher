var Point = {
    url         : "/Point",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Point/Views/Point.html',
            controller  : 'PointCtrl'
        }
    }
};
var PointNew = {
    url         : "/PointNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Point/Views/PointNew.html',
            controller  : 'PointNewCtrl'
        }
    }
};
var PointEdit = {
    url         : "/PointEdit/:pntID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Point/Views/PointEdit.html',
            controller  : 'PointEditCtrl'
        }
    }
};
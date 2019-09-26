var Travel = {
    url         : "/Travel",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Views/Travel.html',
            controller  : 'TravelCtrl'
        }
    }
};
var TravelNew = {
    url         : "/TravelNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Views/TravelNew.html',
            controller  : 'TravelNewCtrl'
        }
    }
};
var TravelEdit = {
    url         : "/TravelEdit/:trID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/Views/TravelEdit.html',
            controller  : 'TravelEditCtrl'
        }
    }
};

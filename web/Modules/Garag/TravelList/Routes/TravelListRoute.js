var TravelList = {
    url         : "/TravelList",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/TravelList/Views/TravelList.html',
            controller  : 'TravelListCtrl'
        }
    }
};
var TravelListNew = {
    url         : "/TravelListNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/TravelList/Views/TravelListNew.html',
            controller  : 'TravelListNewCtrl'
        }
    }
};
var TravelListEdit = {
    url         : "/TravelListEdit/:dcID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/TravelList/Views/TravelListEdit.html',
            controller  : 'TravelListEditCtrl'
        }
    }
};
var TravelListAdd = {
    url   : "/TravelListAdd/:dcID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Garag/TravelList/Views/TravelListNew.html',
            controller  : 'TravelListNewCtrl'
        }
    }
};

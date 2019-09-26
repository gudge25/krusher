const Deals = {
    data  : { Name: `deal`, Small: `allSales`} ,
    url   : "/Deals",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Deals/Views/Deal.html',
            controller  : 'DealCtrl'
        }
    }
};
const DealNew = {
    url   : "/DealNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Deals/Views/DealNew.html',
            controller  : 'DealNewCtrl'
        }
    }
};

const DealAdd = {
    url   : "/DealAdd/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Deals/Views/DealNew.html',
            controller  : 'DealNewCtrl'
        }
    }
};

const DealEdit = {
    data  : { Name: `deal`, Small: `allSales`},
    url   : "/DealEdit/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Deals/Views/DealEdit.html',
            controller  : 'DealEditCtrl'
        }
    }
};
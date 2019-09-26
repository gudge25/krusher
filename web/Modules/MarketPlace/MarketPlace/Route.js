const mpMarketplace = {
    data: { Name: `mpMarketplaces`, Small: ``} ,
    url   : "/mpMarketplace",
    views : {
        "viewA": {
            templateUrl: Gulp + 'MarketPlace/MarketPlace/Views/All.html',
            controller: 'mpMarketplaceCtrl'
        }
    }
};
const mpMarketplaceNew = {
    data: { Name: `mpMarketplaces`, Small: ``} ,
    url   : "/mpMarketplaceNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'MarketPlace/MarketPlace/Views/New.html',
            controller: 'mpMarketplaceNewCtrl'
        }
    }
};
const mpMarketplaceEdit = {
    data: { Name: `mpMarketplaces`, Small: ``} ,
    url   : "/mpMarketplaceEdit/{mpID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'MarketPlace/MarketPlace/Views/Edit.html',
            controller: 'mpMarketplaceEditCtrl'
        }
    }
};
const mpMarketplaceInstallEdit = {
    data: { Name: `mpMarketplaces`, Small: ``} ,
    url   : "/mpMarketplaceInstallEdit/{mpiID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'MarketPlace/MarketPlaceInstall/Views/Edit.html',
            controller: 'mpMarketplaceInstallEditCtrl'
        }
    }
};
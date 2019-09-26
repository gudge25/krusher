const FavoritesRoute = {
	data: { Name: `Favorites`, Small: ``} ,
    url   : "/Favorites",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Us/Favorites/Views/All.html',
            controller  : 'FavoritesPreViewCtrl'
        }
    }
};

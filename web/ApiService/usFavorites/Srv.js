class FavoritesSrv extends BaseSrv {
    constructor()
    {
        super(API.Favorites, FavoritesModel,'uID');
    }
}
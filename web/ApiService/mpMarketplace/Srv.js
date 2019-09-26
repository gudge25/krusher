class mpMarketplaceSrv extends BaseSrv {
    constructor()
    {
        super(API.mp.Marketplace, mpMarketplaceModel, 'mpID');
    }
}
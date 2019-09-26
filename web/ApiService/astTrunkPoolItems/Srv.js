class astTrunkPoolItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.TrunkPoolList, astTrunkPoolItemsModel, 'plID');
    }
}
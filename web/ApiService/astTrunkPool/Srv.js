class astTrunkPoolSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.TrunkPool, astTrunkPoolModel, 'poolID');
    }
}
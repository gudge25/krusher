class astTrunkSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Trunk, astTrunkModel, 'trID');
    }
}
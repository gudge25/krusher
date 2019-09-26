class astTimeGroupSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.TimeGroup, astTimeGroupModel, 'tgID');
    }
}
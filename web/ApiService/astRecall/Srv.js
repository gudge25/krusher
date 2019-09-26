class astRecallSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Recall, astRecallModel, 'rcID');
    }
}
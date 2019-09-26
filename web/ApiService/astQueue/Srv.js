class astQueueSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Queue, astQueueModel, 'queID');
    }
}
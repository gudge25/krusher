class hooksSrv extends BaseSrv {
    constructor()
    {
        super(API.hooks, hooksModel, 'id');
    }
}
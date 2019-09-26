class hClientSrv extends BaseSrv {
    constructor()
    {
        super(API.History.Client, hClientModel, 'clID');
    }
}
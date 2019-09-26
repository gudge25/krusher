class dcDocClientSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.Doc, dcDocClientModel, 'dcID');
    }
}
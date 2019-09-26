class dcDocsClientSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.Docs, dcDocsClientModel, 'dcID');
    }
}
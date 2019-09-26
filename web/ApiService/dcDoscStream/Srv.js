class dcDocsStreamSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.Stream, dcDocsStreamModel, 'emID');
    }
}
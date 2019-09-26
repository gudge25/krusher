class dcDocsSearchSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.DocsSearch, dcDocsSearchModel, 'dcID');
    }
}
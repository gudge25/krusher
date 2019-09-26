class dcDocsHistorySrv extends BaseSrv {
    constructor()
    {
        super(API.dc.DocsHistory, dcDocsHistoryModel, 'dcID');
    }
}
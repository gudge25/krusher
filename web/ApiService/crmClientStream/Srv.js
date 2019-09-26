class crmClientStreamSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Stream, crmClientStreamModel, 'ClientStreamID');
    }
}
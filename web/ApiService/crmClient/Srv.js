class crmClientSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.All, crmClientModel, 'clID');
    }
}
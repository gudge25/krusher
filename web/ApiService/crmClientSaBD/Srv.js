class crmClientSaBDSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.SaBD, crmClientSaBDModel, 'clID');
    }
}
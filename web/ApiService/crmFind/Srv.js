class crmClientFindSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.All, crmClientFindModel, 'clName');
    }
}
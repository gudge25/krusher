class crmClientSearchSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Search, crmClientSearchModel, 'clName');
    }
}
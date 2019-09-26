class crmTagSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Tag, crmTagModel, 'ctgID');
    }
}
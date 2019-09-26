class crmClientSearch2Srv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Search, crmClientSearch2Model, 'clID');
    }
}
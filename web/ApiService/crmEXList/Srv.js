class crmClientExListSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.ExList, crmClientExListModel, 'clID');
    }
}
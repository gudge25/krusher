class crmContactSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Contact, crmContactModel, 'ccID');
    }
}
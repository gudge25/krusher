class crmPersonSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Person, crmPersonModel, 'pnID');
    }
}
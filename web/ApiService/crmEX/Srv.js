class crmClientExSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Ex, crmClientExModel, 'clID');
    }
}
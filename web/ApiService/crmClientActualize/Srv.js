class crmClientActualizeSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Actualize, crmClientActualizeModel, 'clID');
    }
}
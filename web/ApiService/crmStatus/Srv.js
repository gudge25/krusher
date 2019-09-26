class StatusSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.status, StatusModel, 'clID');
    }
}
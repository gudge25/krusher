class crmResponsibleSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Responsible.Responsible, crmResponsibleModel, 'crID');
    }
}
class crmResponsibleListSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Responsible.List, crmResponsibleListModel, 'emID');
    }
}
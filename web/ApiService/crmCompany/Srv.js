class crmCompanySrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Company, crmCompanyModel, 'coID');
    }
}
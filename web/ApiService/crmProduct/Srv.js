class crmProductSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Product, crmProductModel, 'cpID');
    }
}
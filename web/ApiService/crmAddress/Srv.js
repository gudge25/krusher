class crmAddressSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Address, crmAddressModel, 'adsID');
    }
}
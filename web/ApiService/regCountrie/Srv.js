class regCountrySrv extends BaseSrv {
    constructor()
    {
        super(API.reg.countries, regCountryModel, 'cID');
    }
}
class regRegionSrv extends BaseSrv {
    constructor()
    {
        super(API.reg.regions, regRegionModel, 'rgID');
    }
}
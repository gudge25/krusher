class gaDriverSrv extends BaseSrv {
    constructor()
    {
        super(API.ga.Driver, gaDriverModel, 'drvID')
    }
}
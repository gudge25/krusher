class gaCarSrv extends BaseSrv {
    constructor()
    {
        super(API.ga.Car, gaCarModel, 'carID')
    }
}
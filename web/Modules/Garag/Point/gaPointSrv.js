class gaPointSrv extends BaseSrv {
    constructor()
    {
        super(API.ga.Point, gaPointModel, 'pntID')
    }
}
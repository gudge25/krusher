class gaTravelSrv extends BaseSrv {
    constructor()
    {
        super(API.ga.Travel, gaTravelModel, 'trID')
    }
}
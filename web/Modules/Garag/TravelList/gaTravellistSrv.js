class gaTravelistSrv extends BaseSrv {
    constructor()
    {
        super(API.ga.Travellist, gaTravellistModel, 'dcID')
    }
}
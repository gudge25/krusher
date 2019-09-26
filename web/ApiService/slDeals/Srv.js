class slDealSrv extends BaseSrv {
    constructor()
    {
        super(API.sl.Deal, slDealModel, 'dcID');
    }
}
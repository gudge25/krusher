class slDealItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.sl.DealItems, slDealItemsModel, 'diID');
    }
}
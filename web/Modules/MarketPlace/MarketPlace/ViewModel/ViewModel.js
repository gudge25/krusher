class mpMarketplaceViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new mpMarketplaceSrv());
        this.Find();
    }
}
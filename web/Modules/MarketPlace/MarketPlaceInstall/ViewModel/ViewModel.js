class mpMarketplaceInstallViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new mpMarketplaceInstallSrv());
        this.Find();
    }
}
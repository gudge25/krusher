class stBrandsViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new stBrandsSrv());
        this.Find();
    }
}
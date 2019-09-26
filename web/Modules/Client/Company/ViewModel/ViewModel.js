class crmCompanyViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new crmCompanySrv());
        this.Find();
    }
}
class crmClientNewViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new crmClientSrv());
    }
}
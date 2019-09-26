class crmTagViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new crmTagSrv());
    }
}
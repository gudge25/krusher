class astRecordViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astRecordSrv());
    }
}
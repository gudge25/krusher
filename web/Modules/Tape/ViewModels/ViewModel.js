class crmClientStreamViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new crmClientStreamSrv());
    }
}

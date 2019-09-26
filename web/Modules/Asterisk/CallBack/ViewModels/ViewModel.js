class astCallBackViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astCallBackSrv(), $translate);
    }
}
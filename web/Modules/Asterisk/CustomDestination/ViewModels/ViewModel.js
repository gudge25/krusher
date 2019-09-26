class astCustomDestinationViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astCustomDestinationSrv(), $translate);
    }
}
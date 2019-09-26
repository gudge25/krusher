class astRouteOutViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astRouteOutSrv(), $translate);
    }
}
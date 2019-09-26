class astTimeGroupViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astTimeGroupSrv(), $translate);
    }
}
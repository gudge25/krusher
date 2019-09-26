class astConferenceViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astConferenceSrv(), $translate);
    }
}
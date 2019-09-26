class SIPViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astSippeersSrv());
    }
}
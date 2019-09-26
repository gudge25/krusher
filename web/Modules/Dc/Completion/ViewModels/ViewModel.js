class CompletionViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new CompletionSrv());
    }
}
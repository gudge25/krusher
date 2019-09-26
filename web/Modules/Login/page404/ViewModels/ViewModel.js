class page404ViewModel extends BaseViewModel {
    constructor($scope,$timeout,$stateParams,$filter,$translate)
    {
        super($scope,$filter,new emEmployeeClientsSrv(), $translate);


    }
}
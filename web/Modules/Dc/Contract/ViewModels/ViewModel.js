class ContractViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new ContractSrv());
    }
}
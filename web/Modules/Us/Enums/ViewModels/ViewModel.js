class usEnumsViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new usEnumsSrv());
    }
}
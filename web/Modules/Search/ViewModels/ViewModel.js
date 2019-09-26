class dcDocsSearchViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new dcDocsSearchSrv());
    }
}
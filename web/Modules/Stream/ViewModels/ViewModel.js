class dcDocsStreamViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new dcDocsStreamSrv());
    }
}
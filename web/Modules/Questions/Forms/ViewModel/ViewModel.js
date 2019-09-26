class fmFormViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter,new dcDocsSearchSrv(),$translate);
        //super($scope,$filter,new fmFormTypesSrv(),$translate);
	}
}
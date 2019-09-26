class dcTemplatesViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter,new dcTemplatesSrv());
        //new dcDocsTypesSrv().getFind({},cb => { $scope.type = cb; $scope.$apply();});
		$scope.model = { dctID: null };

        $scope.getTemplate = dctID => {
			if(dctID != $scope.model.dctID){
				$scope.model = { dctID };
				this.Find();
			}
        };

        $scope.settings = 'Editor';
    }
}
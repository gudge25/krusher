class regRegionViewModel extends BaseViewModel {
	constructor($scope,$filter,$translate,$rootScope)
	{
		super($scope,$filter,new regRegionSrv(),$translate);
		$scope.model = { "cID" : 2 };
 		$scope.new = new regRegionModel($scope.model).post();
        $scope.GetArea = () => {
            this.Find();
        };
        $scope.GetArea();
	}
}
class regLocationViewModel extends BaseViewModel {
	constructor($scope,$filter,$translate,$rootScope)
	{
		super($scope,$filter,new regLocationSrv(),$translate);
		$scope.model = { "cID" : 2 };
		$scope.new = new regLocationModel($scope.model).post();
		new regRegionSrv().getFind({ cID : $scope.model.cID },cb => { $scope.Region = cb; $scope.$apply();});
        $scope.GetArea = () => {
             this.Find();
        };
 	}
}
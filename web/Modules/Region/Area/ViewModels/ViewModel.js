class regAreaViewModel extends BaseViewModel {
	constructor($scope,$filter,$translate,$rootScope)
	{
		super($scope,$filter,new regAreaSrv(),$translate);
		$scope.model = { "cID" : 2 };
		$scope.new = new regAreaModel($scope.model).post();

		new regRegionSrv().getFind({ cID : $scope.model.cID },cb => { $scope.Region = cb; $scope.$apply();});

        $scope.GetArea = () => {
            this.Find();
        };
        $scope.GetArea();
	}
}
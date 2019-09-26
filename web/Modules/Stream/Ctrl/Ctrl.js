crmUA.controller('StreamCtrl', function($scope ,$filter) {
    $scope.manyAction =  new dcDocsStreamViewModel($scope, $filter);
    $scope.showFilter = false;

    new dcDocsStreamSrv().getAll( 	cb => { $scope.data = cb; 			$scope.$apply();});
    new emEmployeeSrv().getFind({},	cb => { $scope.employees = cb; 		$scope.$apply();});
});
crmUA.controller('priorityCtrl', function($scope,$filter) {
    $scope.manyAction =  new fsViewModel($scope, $filter);
    $scope.LoadingStatus=false;
    $scope.ffID = null;
    $scope.model = new fsFileModel('').postFind();
	$scope.manyAction.Find();
});
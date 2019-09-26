crmUA.controller('RecallCtrl', function($scope ,$filter) {
    $scope.manyAction =  new astRecallViewModel($scope, $filter);
    $scope.model = new astRecallModel('').postFind();
	$scope.manyAction.Find();
});
crmUA.controller('RecordCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astRecordViewModel($scope, $filter);
    $scope.model = new astRecordModel('').postFind();
	$scope.manyAction.Find();
});
crmUA.controller('IVRCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astIVRViewModel($scope, $filter);
	$scope.model = new astIVRModel('').postFind();
	$scope.manyAction.Find();
});
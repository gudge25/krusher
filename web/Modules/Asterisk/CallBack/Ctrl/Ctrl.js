crmUA.controller('CallBackCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astCallBackViewModel($scope,$filter,$translate,$rootScope);
	$scope.model = new astCallBackModel('').postFind();
    $scope.manyAction.Find();
});
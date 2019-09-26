crmUA.controller('SIPCtrl', function($scope, $filter, $translate, $translatePartialLoader,Auth) {
    $scope.manyAction =  new SIPViewModel($scope, $filter);
	$scope.manyAction.Find();
	$scope.model = new astSippeersModel().postFind();
	$scope.Auth = Auth.FFF;
});
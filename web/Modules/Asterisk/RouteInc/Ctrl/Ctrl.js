crmUA.controller('RouteIncCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astRouteIncViewModel($scope, $filter);
	$scope.model = new astRouteIncModel('').postFind();
	$scope.manyAction.Find();
});
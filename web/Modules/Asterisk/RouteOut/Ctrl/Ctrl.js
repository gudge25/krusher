crmUA.controller('RouteOutCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astRouteOutViewModel($scope,$filter,$translate,$rootScope);
	$scope.model = new astRouteOutModel('').postFind();
    $scope.manyAction.Find();
});
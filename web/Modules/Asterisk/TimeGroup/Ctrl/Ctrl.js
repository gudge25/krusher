crmUA.controller('TimeGroupCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astTimeGroupViewModel($scope,$filter,$translate,$rootScope);
	$scope.model = new astTimeGroupModel('').postFind();
    $scope.manyAction.Find();
});
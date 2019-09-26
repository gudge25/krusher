crmUA.controller('ScenarioCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astScenarioViewModel($scope, $filter);
    $scope.model = new astScenarioModel('').postFind();
	$scope.manyAction.Find();
});
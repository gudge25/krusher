crmUA.controller('ScenarioNewCtrl', function($scope,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astScenarioViewModel($scope, $filter);
    $scope.new = new astScenarioModel('').put();
});

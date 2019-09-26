crmUA.controller('ScenarioEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astScenarioViewModel($scope, $filter);
    var id_scenario = $stateParams.id_scenario;
    new astScenarioSrv().getFind({id_scenario},cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
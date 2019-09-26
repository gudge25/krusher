crmUA.controller('DriverEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new gaDriverViewModel($scope, $filter);

    new gaDriverSrv().get($stateParams.drvID, cb => { $scope.upd = cb; $scope.$apply(); });
});
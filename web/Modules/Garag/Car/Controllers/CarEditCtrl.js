crmUA.controller('CarEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new gaCarViewModel($scope, $filter);

    new gaCarSrv().get($stateParams.carID,cb => { $scope.upd = cb; $scope.$apply(); });
});


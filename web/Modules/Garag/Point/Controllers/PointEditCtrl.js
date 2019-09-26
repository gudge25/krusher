crmUA.controller('PointEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new gaPointViewModel($scope, $filter);

    new gaPointSrv().get($stateParams.pntID,cb => { $scope.upd = cb; $scope.$apply(); });
});
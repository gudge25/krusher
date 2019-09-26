crmUA.controller('crmTagListEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new crmTagViewModel($scope, $filter);

    new crmTagSrv().getFind({tagID:$stateParams.tagID},cb => { $scope.upd = cb[0]; $scope.$apply(); });
});
crmUA.controller('CustomDestinationEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astCustomDestinationViewModel($scope,$filter,$translate,$rootScope);
    var cdID = $stateParams.cdID;
    new astCustomDestinationSrv().getFind({cdID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
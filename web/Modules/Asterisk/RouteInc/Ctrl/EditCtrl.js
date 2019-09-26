crmUA.controller('RouteIncEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astRouteIncViewModel($scope, $filter);
    var rtID = $stateParams.rtID;
    new astRouteIncSrv().getFind({rtID},cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
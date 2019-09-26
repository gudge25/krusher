crmUA.controller('SIPCtrlEdit', function($scope,  $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new SIPViewModel($scope, $filter);
    var sipID = $stateParams.sipID;
    new astSippeersSrv().getFind({sipID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
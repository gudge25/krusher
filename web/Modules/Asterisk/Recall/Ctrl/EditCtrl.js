crmUA.controller('RecallEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new astRecallViewModel($scope, $filter);
    var rcID = $stateParams.rcID;
    new astRecallSrv().getFind({rcID},cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
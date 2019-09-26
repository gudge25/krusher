crmUA.controller('RecordEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astRecordViewModel($scope, $filter);
    var record_id = $stateParams.record_id;
    new astRecordSrv().getFind({record_id},cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
crmUA.controller('TTSEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astTTSViewModel($scope, $filter);
    var id = $stateParams.ttsID;
    new astTTSSrv().getFind({  ttsID: id },cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404";  });

    new astTTSFieldsSrv().getFind({}, cb => { $scope.TTSFields = cb; });
});
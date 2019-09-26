crmUA.controller('TrunkCtrlEdit', function($scope,  $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new TrunkViewModel($scope, $filter);
    var trID = $stateParams.trID;
    new astTrunkSrv().getFind({trID},cb => { if(cb.length > 0){ $scope.GoIP(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });


});
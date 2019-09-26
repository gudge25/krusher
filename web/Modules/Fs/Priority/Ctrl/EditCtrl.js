crmUA.controller('priorityEditCtrl', function($scope,$filter,$stateParams,$translate,$rootScope) {
    $scope.manyAction =  new fsViewModel($scope, $filter);
    let ffID = $stateParams.ffID;
    new fsFileSrv().getFind({ffID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.$apply(); } else  window.location = "#!/page404"; });
});
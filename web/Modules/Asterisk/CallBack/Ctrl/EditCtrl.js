crmUA.controller('CallBackEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astCallBackViewModel($scope,$filter,$translate,$rootScope);
    var cbID = $stateParams.cbID;
    $scope.modelItems = { cbID , limit : 15 };
    new astCallBackSrv().getFind({cbID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
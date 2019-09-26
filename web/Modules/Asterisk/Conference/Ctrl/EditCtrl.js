crmUA.controller('ConferenceEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astConferenceViewModel($scope,$filter,$translate,$rootScope);
    var cfID = $stateParams.cfID;
    new astConferenceSrv().getFind({cfID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
});
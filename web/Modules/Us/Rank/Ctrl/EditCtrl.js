crmUA.controller('RankEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new usRankViewModel($scope, $filter);
    var id = $stateParams.uID;
    //new usRankSrv().get(id,cb => { $scope.upd = cb; $scope.$apply();});
});
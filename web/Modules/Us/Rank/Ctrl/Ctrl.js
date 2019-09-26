crmUA.controller('RankCtrl', function($scope ,$filter) {
    $scope.manyAction =  new usRankViewModel($scope, $filter);
    //new usRankSrv().getFind({}, cb => { $scope.data = cb; $scope.$apply();});
});
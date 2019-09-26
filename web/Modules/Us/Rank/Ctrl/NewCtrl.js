crmUA.controller('RankNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new usRankViewModel($scope, $filter);
    $scope.new = new usRankModel('').post();
});
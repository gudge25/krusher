crmUA.controller('RecallNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new astRecallViewModel($scope, $filter);
    $scope.new = new astRecallModel('').put();
});

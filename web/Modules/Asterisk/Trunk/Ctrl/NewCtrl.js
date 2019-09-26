crmUA.controller('TrunkCtrlNew', function($scope, $filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new TrunkViewModel($scope, $filter);
    $scope.new = new astTrunkModel('').put();
});
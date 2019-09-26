crmUA.controller('SIPCtrlNew', function($scope, $filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new SIPViewModel($scope, $filter);
    $scope.new = new astSippeersModel('').put();
});
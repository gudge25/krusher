crmUA.controller('CallBackCtrlNew', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astCallBackViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astCallBackModel('').put();
});
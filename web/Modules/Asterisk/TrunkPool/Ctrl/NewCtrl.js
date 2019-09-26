crmUA.controller('TrunkPoolNewCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astTrunkPoolViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astTrunkPoolModel('').put();
});
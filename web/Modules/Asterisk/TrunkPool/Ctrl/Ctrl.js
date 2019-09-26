crmUA.controller('TrunkPoolCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astTrunkPoolViewModel($scope,$filter,$translate,$rootScope);
    $scope.manyAction.Find();
    $scope.model = new astTrunkPoolModel('').postFind();

});
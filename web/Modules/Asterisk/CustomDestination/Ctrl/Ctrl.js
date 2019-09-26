crmUA.controller('CustomDestinationCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astCustomDestinationViewModel($scope,$filter,$translate,$rootScope);
    $scope.model = new astCustomDestinationModel('').postFind();
    $scope.manyAction.Find();
});
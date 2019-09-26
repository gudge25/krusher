crmUA.controller('CustomDestinationNewCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astCustomDestinationViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astCustomDestinationModel('').put();
});
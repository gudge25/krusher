crmUA.controller('OperatorNewCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regOperatorViewModel($scope,$filter,$translate,$rootScope);
});
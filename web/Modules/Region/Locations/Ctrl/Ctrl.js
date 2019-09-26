crmUA.controller('LocationCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regLocationViewModel($scope,$filter,$translate,$rootScope);
});
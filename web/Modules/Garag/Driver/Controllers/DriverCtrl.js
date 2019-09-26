crmUA.controller('DriverCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaDriverViewModel($scope, $filter);
});
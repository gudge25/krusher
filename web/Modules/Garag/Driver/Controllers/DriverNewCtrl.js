crmUA.controller('DriverNewCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaDriverViewModel($scope, $filter);
});
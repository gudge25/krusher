crmUA.controller('CarNewCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaCarViewModel($scope, $filter);
});
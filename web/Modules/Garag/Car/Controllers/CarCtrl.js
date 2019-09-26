crmUA.controller('CarCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaCarViewModel($scope, $filter);
});
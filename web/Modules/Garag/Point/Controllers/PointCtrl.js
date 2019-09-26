crmUA.controller('PointCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaPointViewModel($scope, $filter);
});
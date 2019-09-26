crmUA.controller('PointNewCtrl', function($scope, $filter) {
    $scope.manyAction =  new gaPointViewModel($scope, $filter);
});
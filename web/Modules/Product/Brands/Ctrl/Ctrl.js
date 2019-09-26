crmUA.controller('BrandsCtrl', function($scope ,$filter) {
    $scope.manyAction =  new stBrandsViewModel($scope, $filter);
});
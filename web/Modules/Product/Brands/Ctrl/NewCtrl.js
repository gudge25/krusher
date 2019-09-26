crmUA.controller('BrandsNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new stBrandsViewModel($scope, $filter);
    $scope.new = new stBrandsModel('').put();
});
crmUA.controller('ProductNewCtrl', function($scope,$filter,$translate,$rootScope) {
    $scope.manyAction =  new stProductViewModel($scope,$filter,$translate,$rootScope);

    $scope.new = new stProductModel('').post();

    $scope.name = false;
    $scope.Select = name => {
        $scope.name = name;
    };
});
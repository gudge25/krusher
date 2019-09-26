crmUA.controller('CategoriesNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new stCategoriesViewModel($scope, $filter);
    $scope.new = new stCategoriesModel('').put();
});
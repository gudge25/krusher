crmUA.controller('CategoriesCtrl', function($scope ,$filter) {
    $scope.manyAction =  new stCategoriesViewModel($scope, $filter);
});
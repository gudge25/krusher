crmUA.controller('ValidationNewCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regValidationViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new regValidationModel('').put();
});
crmUA.controller('ValidationCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regValidationViewModel($scope,$filter,$translate,$rootScope);
});
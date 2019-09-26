crmUA.controller('TemplatesCtrl', function($scope,$filter,$translate,$rootScope) {
    $scope.manyAction =  new dcTemplatesViewModel($scope,$filter,$translate,$rootScope);
});
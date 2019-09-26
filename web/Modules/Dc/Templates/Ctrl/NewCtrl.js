crmUA.controller('TemplatesNewCtrl', function($scope,$filter,$translate,$rootScope) {
    $scope.manyAction =  new dcTemplatesViewModel($scope,$filter,$translate,$rootScope);

    $scope.new = new dcTemplatesModel('').put();
});
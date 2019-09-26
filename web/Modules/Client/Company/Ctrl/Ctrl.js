crmUA.controller('crmCompanyCtrl', function($scope, $filter) {
    $scope.manyAction =  new crmCompanyViewModel($scope, $filter);
    $scope.model = new crmCompanyModel('').postFind();
});
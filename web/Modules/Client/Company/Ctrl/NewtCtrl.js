crmUA.controller('crmCompanyNewCtrl', function($scope, $filter) {
    $scope.manyAction =  new crmCompanyViewModel($scope, $filter);
    $scope.new = new crmCompanyModel('').put();
});
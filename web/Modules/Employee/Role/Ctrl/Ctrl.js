crmUA.controller('emEmployeeRoleAllCtrl', function($scope, $filter,$translate, $rootScope) {
    $scope.manyAction =  new emEmployeeRoleViewModel($scope, $filter,$translate);
    $scope.model = new emEmployeeRoleModel('').postFind();

});
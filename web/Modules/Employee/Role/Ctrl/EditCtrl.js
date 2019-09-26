crmUA.controller('emEmployeeRoleEditCtrl', function($scope, $filter, $stateParams) {

    $scope.manyAction =  new emEmployeeRoleViewModel($scope, $filter);

    var roleID = $stateParams.roleID;
	new emEmployeeRoleSrv().getFind( {roleID}, cb =>{ $scope.upd = cb[0]; $scope.$apply();});
});
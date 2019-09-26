crmUA.controller('ValidationEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new regValidationViewModel($scope,$filter,$translate,$rootScope);
    var vID = $stateParams.vID;
    //var cID = $stateParams.cID;
    new regValidationSrv().getFind({vID}, cb => { $scope.upd = cb[0]; $scope.$apply();});
	//$scope.Filter.cID = parseInt(cID);
	$scope.GetArea();
	$scope.GetOperator();
});
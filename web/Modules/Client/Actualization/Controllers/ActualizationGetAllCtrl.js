crmUA.controller('ActualizationCtrlGetAll', function($scope, $timeout, $filter, $uibModal, Autocall, Progress) {
	$scope.autocall = Autocall;

    $scope.autocall.FFF = false;
	$scope.manyAction =  new ActualizationViewModel($scope, $timeout, $filter, $uibModal);

    $scope.Progress = Progress;
});
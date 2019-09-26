function Cli($scope,$http,$locale,$timeout,$filter) {
	var rest_url = 'REST/asterisk.php?';
	$scope.CLI = a => {
		$scope.check = false;
		$http.get(rest_url + a).success( data => {  $scope.check = true; }).error( (request, status, error) => { $scope.check = true; });
	};
	$scope.check = true;
	$scope.value2 = $scope.value1 = 'Disabled';
}
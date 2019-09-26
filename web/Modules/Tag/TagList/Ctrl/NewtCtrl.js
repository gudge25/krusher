crmUA.controller('crmTagListNewCtrl', function($scope, $filter) {
    $scope.manyAction =  new crmTagViewModel($scope, $filter);
	$scope.new = new crmTagModel('').post();
});
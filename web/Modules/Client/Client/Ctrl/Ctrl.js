crmUA.controller('crmClientCtrlGetAll', function($scope, $timeout, $filter, $uibModal,  $translate, $rootScope, Pages, Auth, HotDial) {
    $scope.Pages = Pages;
    $scope.Auth = Auth.FFF;
    $scope.HotDial = HotDial;
    $scope.manyAction =  new crmClientViewModel($scope, $timeout, $filter, $uibModal, $translate, $rootScope);

    $scope.ClearFilter = () => {
    	$scope.Filter.Filter.cID 			= null;
    	$scope.Filter.Filter.emID 			= null;
    	$scope.Filter.Filter.CallDate 		= null;
    	$scope.Filter.Filter.CallDateTo 	= null;
    	$scope.Filter.Filter.clName			= null;
    	$scope.Filter.Filter.clID 			= null;
    	$scope.model.CurrentPage			= 1;
		$scope.FindClient($scope.Filter.Filter);
    };
});
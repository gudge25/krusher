crmUA.controller('TrunkPoolEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astTrunkPoolViewModel($scope,$filter,$translate,$rootScope);
    var poolID = $stateParams.poolID;
    $scope.model = { poolID };
  	$scope.modelItems = { poolID , limit : 15 };
  	$scope.ItemsSrv 	= new astTrunkPoolItemsSrv();
	$scope.ItemsModel 	= astTrunkPoolItemsModel;

	new astTrunkPoolSrv().getFind({poolID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.manyAction.Find($scope.ItemsSrv); $scope.$apply(); } else  window.location = "#!/page404"; });
});
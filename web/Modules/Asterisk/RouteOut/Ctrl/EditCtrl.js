crmUA.controller('RouteOutEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astRouteOutViewModel($scope,$filter,$translate,$rootScope);
    var roID = $stateParams.roID;
    $scope.modelItems = { roID , limit : 15 };

	$scope.ItemsSrv 	= new astRouteOutItemsSrv();
	$scope.ItemsModel 	= astRouteOutItemsModel;
    new astRouteOutSrv().getFind({roID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.manyAction.Find($scope.ItemsSrv); $scope.$apply(); } else  window.location = "#!/page404"; });
});
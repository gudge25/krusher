crmUA.controller('TimeGroupEditCtrl', function($scope, $filter, $translate, $stateParams, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new astTimeGroupViewModel($scope,$filter,$translate,$rootScope);
    var tgID = $stateParams.tgID;
    $scope.modelItems = { tgID , limit : 15 };

	$scope.ItemsSrv 	= new astTimeGroupItemsSrv();
	$scope.ItemsModel 	= astTimeGroupItemsModel;
    new astTimeGroupSrv().getFind({tgID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.manyAction.Find($scope.ItemsSrv); $scope.$apply(); } else  window.location = "#!/page404"; });
});
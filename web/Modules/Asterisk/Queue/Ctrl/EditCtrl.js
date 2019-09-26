crmUA.controller('QueueEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astQueueViewModel($scope, $filter);

    const queID = $stateParams.queID;
    $scope.model = { queID };

  	$scope.modelItems = { queID , limit : 15 };

  	$scope.ItemsSrv 	= new astQueueMemberSrv();
	$scope.ItemsModel 	= astQueueMemberModel;

    new astQueueSrv().getFind($scope.model,cb => {
        if(cb.length > 0){ $scope.upd = cb[0]; $scope.manyAction.Find($scope.ItemsSrv);  $scope.$apply(); } else  window.location = "#!/page404";
    });


});
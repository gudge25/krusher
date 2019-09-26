crmUA.controller('IVREditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astIVRViewModel($scope, $filter);
    var id_ivr_config = $stateParams.id_IVR;


    $scope.modelItems = { id_ivr_config , limit : 15 };

	$scope.ItemsSrv 	= new astIVREntrySrv();
	$scope.ItemsModel 	= astIVRItemsModel;
    new astIVRConfigSrv().getFind({id_ivr_config}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.$apply(); $scope.manyAction.Find($scope.ItemsSrv); } else  window.location = "#!/page404";  });


  //   new astIVRConfigSrv().getFind({  id_ivr_config : id},cb => {
  //       cb.map( x => {
		//                x.invalid_destination = parseInt(x.invalid_destination);
		//                x.timeout_destination = parseInt(x.timeout_destination);
		//                return x;
		// });
		// $scope.upd          = cb[0];
		// new astIVREntrySrv().getFind({  id_ivr_config : id }, cb => {
		// 		$scope.Items = cb;
		// 		$scope.Items.map( x => {
		// 			   if(x.destination != "101402"){
		// 	               x.destdata 		= parseInt(x.destdata);
		// 	           }
		// 			   x.destination 	= parseInt(x.destination);
		//                return x;
		// 		});
		// 		$scope.$apply();
		// });
  //       $scope.$apply();
  //   });
});
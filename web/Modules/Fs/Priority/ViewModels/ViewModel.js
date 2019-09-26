class fsViewModel extends BaseViewModel {
    constructor($scope, $filter) {
        super($scope, $filter, new fsFileSrv());
		$scope.UpdStatus = ffid => {
			$scope.LoadingStatus=true;
			$scope.ffID = ffid;
			new fsUpdStatusSrv().ins({"url":ffid}, cb => { $scope.LoadingStatus=false; $scope.ffID = null; $scope.$apply(); alert(`Статуcы для файла пересчитаны!`); } );
		};
		$scope.Export = id => {
       		 new fsExportSrv().fileDownload(id);
    	};
    }
}
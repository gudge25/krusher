function QueueLog($scope,$http,$locale,$timeout,$filter) {
	
	
	 $scope.NOW 	= new Date();


	 //DATAPIKER
      	 $scope.untilDate 	= new Date().toISOString();
     	 $scope.fromDate 	= new Date().addDays(-30).toISOString();

	 $scope.fromDate = $filter('date')($scope.fromDate, 'yyyy-MM-ddT00:00:01')
	 console.log($scope.untilDate)


$scope.fromDate = $scope.fromDate.split('.')
$scope.fromDate=$scope.fromDate[0]


	 $scope.untilDate = $filter('date')($scope.untilDate, 'yyyy-MM-ddT23:59:59')
	 console.log($scope.untilDate) 
	
	 $scope.load = function()
	 { 
	  	$http.get( api2 + "queue&from="+$scope.fromDate+"&to=" + $scope.untilDate  ).success(function(data){ 
	 	 console.log(data); $scope.queuelog=data;
	 	 $scope.queuelog = _.groupBy($scope.queuelog, 'queuename');
 
	 })
	 
	 
	}
	$scope.load();
	
	
	
	
}

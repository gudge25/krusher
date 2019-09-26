function DashboardCtrl($scope, $filter, $translate, $rootScope, Auth) {
    $scope.manyAction =  new DashboardViewModel($scope, $filter,$translate,$rootScope);
    $scope.auth = Auth;
    $scope.search={
    	a:'',
    	b:''
    };
    $scope.searchB = () => {
    	if($scope.search.b === null) $scope.search.b ='';
    };
    $scope.CoreShowChannels = [];
}
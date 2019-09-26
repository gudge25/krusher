class StatusStatsViewMode extends BaseViewModel {
    constructor($scope, $timeout, $filter, $rootScope, AclService,$translate)
    {
        super($scope,$filter,new emEmployeeStatusStatSrv(),$translate, AclService);

        $scope.SearchClient = a => {
            if(a) $scope.manyAction.SearchClient(a).then( a => { $scope.ClientData = a; $scope.$apply(); });
        };
    }
}
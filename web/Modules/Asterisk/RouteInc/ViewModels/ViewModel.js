class astRouteIncViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astRouteIncSrv());
        $scope.DestType  = $scope.EnumsGroup[1014];       
        $scope.DestTypeCB = $scope.EnumsGroup[1014].filter( x => x.tvID == 101402 || x.tvID == 101401  );   
    }
}
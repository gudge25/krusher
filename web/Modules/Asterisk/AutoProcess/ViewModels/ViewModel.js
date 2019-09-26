class astAutoProcessViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astAutoProcessSrv());
        $scope.DestType  = $scope.EnumsGroup[1014];
        $scope.Process   = $scope.EnumsGroup[1016];
    }
}
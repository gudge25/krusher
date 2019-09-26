class astTTSViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astTTSSrv());
        $scope.DestType  = $scope.EnumsGroup[1014];
        $scope.Process   = $scope.EnumsGroup[1016];
        this.Find();
    }
}
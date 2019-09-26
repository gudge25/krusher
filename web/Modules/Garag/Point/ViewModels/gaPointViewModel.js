class gaPointViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new gaPointSrv);

        new gaPointSrv().getAll(cb =>  { $scope.data = cb; $scope.$apply();});

        $scope.new = new gaPointModel('').post();
    }
}
class gaDriverViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new gaDriverSrv);

        new gaDriverSrv().getAll(cb => { $scope.data = cb; $scope.$apply();});

        $scope.new = new gaDriverModel('').post();
    }
}
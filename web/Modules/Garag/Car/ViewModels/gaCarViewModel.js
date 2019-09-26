class gaCarViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new gaCarSrv);

        new gaCarSrv().getAll(cb => { $scope.data = cb; $scope.$apply();});
        $scope.new = new gaCarModel('').post();
    }
}
class fsBasesViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new fsBasesSrv());

        this.Find();
        $scope.new = new fsBasesModel('').put();
    }
}
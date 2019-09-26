class regOperatorViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter,new regOperatorSrv(),$translate);

        this.Find();
        $scope.new = new regOperatorModel('').post();
        $scope.Filter = { "cID" : 2, "isGsm": 1};
    }
}
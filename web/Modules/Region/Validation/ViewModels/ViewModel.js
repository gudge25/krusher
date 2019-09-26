class regValidationViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new regValidationSrv(), $translate);
        $scope.model = { "cID" : 2, "isGsm": null};

        $scope.GetRegion = () => {
            new regRegionSrv().getFind($scope.model , cb => { $scope.Region = cb; $scope.$apply(); });
            this.Find();
        };
        $scope.GetRegion();

        $scope.GetArea = () => {
            new regAreaSrv().getFind($scope.model, cb => { $scope.Area = cb; $scope.$apply(); });
        };
        $scope.GetArea();

        $scope.GetOperator = () => {
            $scope.operators = [];
            new regOperatorSrv().getFind({},cb => {
                angular.forEach(cb, todo => {
                     if(todo.cID == $scope.model.cID) $scope.operators.push(todo);
                 });
                $scope.$apply();});
         };
        $scope.GetOperator();
    }
}
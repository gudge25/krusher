class astTrunkPoolViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new astTrunkPoolSrv(), $translate);


        $scope.Check = a => {
            var input = false;
            angular.forEach($scope.Items, todo => {
                    if(todo.trID == a.trID) input = true;
            });
            return input;
        };

    }
}
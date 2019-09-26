crmUA.controller('mpMarketplaceInstallEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new mpMarketplaceInstallViewModel($scope, $filter);
    var id = $stateParams.mpiID;

    $scope.$watch('data', () => {
        console.log($scope.data);
        if($scope.data) {
            angular.forEach($scope.data, todo => {
                if( id == todo.mpiID) {
                    $scope.upd=todo; $scope.upd_old=angular.copy(todo);// $scope.$apply();
                }
            });
        }
    });

    // $scope.Check_upd_old = () => {
    //         return angular.equals($scope.upd_old, $scope.upd) ? true : false;
    // };
});
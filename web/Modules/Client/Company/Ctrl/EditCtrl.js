crmUA.controller('crmCompanyEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new crmCompanyViewModel($scope, $filter);
    var id = $stateParams.coID;

    $scope.$watch('data', () => {
        if($scope.data) {
            angular.forEach($scope.data, todo => {
                if( id == todo.coID) {
                    $scope.upd=todo; $scope.upd_old=angular.copy(todo); // $scope.$apply();
                }
            });
        }
    });

    // $scope.Check_upd_old = () => {
    //         return angular.equals($scope.upd_old, $scope.upd) ? true : false;
    // };
});
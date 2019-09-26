crmUA.controller('fsBasesEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new fsBasesViewModel($scope, $filter);
    var id = $stateParams.dbID;

    $scope.$watch('data', () => {
        if($scope.data) {
            angular.forEach($scope.data, todo => {
                if( id == todo.dbID) {
                    $scope.upd=todo; $scope.upd_old = angular.copy(todo); // $scope.$apply();
                }
            });
        }
    });
});
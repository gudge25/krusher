crmUA.controller('DBStatCtrl', function($scope, $filter) {

    new fsFileSrv().getFind({}, cb => {
        angular.forEach(cb, todo => {
            new fsFileSrv().get(todo.ffID, cb2 => { todo.Stats = cb2; $scope.$apply(); });
        });
        $scope.data     = cb;
    });
});
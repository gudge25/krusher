crmUA.controller('CommentEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new ccCommentViewModel($scope, $filter);

    new ccCommentListSrv().getFind({},cb => {
        angular.forEach(cb, todo => {
            if(todo.comID == $stateParams.comID) $scope.upd = todo;
        });
        $scope.$apply();
    });
});
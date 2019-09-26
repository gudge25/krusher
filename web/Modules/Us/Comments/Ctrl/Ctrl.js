crmUA.controller('CommentsCtrl', function($scope ,$filter) {
    $scope.manyAction =  new usCommentsViewModel($scope, $filter);
    new usCommentsSrv().getFind({}, cb => { $scope.data = cb; $scope.$apply();});
});
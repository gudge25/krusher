crmUA.controller('CommentListCtrl', function($scope) {
    new ccCommentListSrv().getFind({ field: `comID`, sorting: `ASC`}, cb => { $scope.CommentList = cb;  $scope.$apply();});
});
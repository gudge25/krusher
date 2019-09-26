crmUA.controller('CommentsEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new usCommentsViewModel($scope, $filter);
    var id = $stateParams.psID;
    new usCommentsSrv().get(id,cb => { $scope.upd = cb; $scope.$apply();});
});
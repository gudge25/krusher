crmUA.controller('CommentsNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new usCommentsViewModel($scope, $filter);
    $scope.new = new usCommentsModel('').post();
});
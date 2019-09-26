crmUA.controller('usEnumsCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new usEnumsViewModel($scope, $filter);
    $scope.model = new usEnumsModel({ limit : 10 }).postFind();
    $scope.manyAction.Find();
});
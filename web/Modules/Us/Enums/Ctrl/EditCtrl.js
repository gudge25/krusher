crmUA.controller('usEnumsEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new usEnumsViewModel($scope, $filter);
    var id = $stateParams.tvID;
    new usEnumsSrv().getFind({ "tvID" : id },cb => {
        $scope.upd          = cb[0]; $scope.upd_old = angular.copy(cb[0]);
        $scope.$apply();
    });
});
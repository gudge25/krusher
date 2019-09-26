crmUA.controller('StreamDetailCtrl', function($scope ,$filter, $stateParams) {
    $scope.manyAction =  new dcDocsStreamViewModel($scope, $filter);
    $scope.Detail = true;
    var id = $stateParams.emID;

    new dcDocsStreamSrv().get(id, cb => { $scope.data = cb; $scope.$apply();});
});
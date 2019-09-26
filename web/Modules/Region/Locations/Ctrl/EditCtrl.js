crmUA.controller('LocationEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new regLocationViewModel($scope,$filter,$translate,$rootScope);

    var lID = $stateParams.lID;
    var cID = $stateParams.cID;

    new regLocationSrv().getFind( { lID }, cb => { $scope.upd = cb[0];  $scope.$apply();});
});
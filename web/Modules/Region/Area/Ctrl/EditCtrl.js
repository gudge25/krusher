crmUA.controller('AreaEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new regAreaViewModel($scope,$filter,$translate,$rootScope);
    var aID = $stateParams.aID;
    var cID = $stateParams.cID;
    new regAreaSrv().getFind( { aID }, cb => { $scope.upd = cb[0]; $scope.$apply();});
});
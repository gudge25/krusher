crmUA.controller('OperatorEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regOperatorViewModel($scope,$filter,$translate,$rootScope);
    var oID = $stateParams.oID;
    new regOperatorSrv().getFind({oID}, cb => { $scope.upd = cb[0]; $scope.$apply();});
});
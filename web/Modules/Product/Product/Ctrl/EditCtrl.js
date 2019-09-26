crmUA.controller('ProductEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader, $rootScope,ModalItems) {
    $scope.manyAction =  new stProductViewModel($scope,$filter,$translate,$rootScope);
    let id;
    $stateParams.psID === undefined ? id = ModalItems.psID : id = $stateParams.psID;
    new stProductSrv().getFind({ psID : id},cb => { $scope.upd = cb[0]; $scope.$apply();});
});
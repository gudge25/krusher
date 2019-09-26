crmUA.controller('BrandsEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new stBrandsViewModel($scope, $filter);

    var bID = $stateParams.bID;

    new stBrandsSrv().getFind({bID},cb => { $scope.upd = cb[0]; });
});
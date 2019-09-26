crmUA.controller('CategoriesEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new stCategoriesViewModel($scope, $filter);
    var psID = $stateParams.psID;
    new stCategoriesSrv().getFind({psID},cb => { $scope.upd = cb[0]; $scope.$apply();});
});
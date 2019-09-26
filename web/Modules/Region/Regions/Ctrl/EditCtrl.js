crmUA.controller('RegionEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new regRegionViewModel($scope,$filter,$translate,$rootScope);

    $scope.model = {
    	rgID : $stateParams.rgID,
    	cID  : $stateParams.cID
    };

    new regRegionSrv().getFind($scope.model, cb => { $scope.upd = cb[0]; $scope.$apply();});
});
crmUA.controller('CountryEditCtrl', function($scope, $filter, $stateParams, $translate, $translatePartialLoader, $rootScope) {
    $scope.manyAction =  new regCountryViewModel($scope,$filter,$translate,$rootScope);

    var id = $stateParams.cID;
    new regCountrySrv().getFind({ cID: id}, cb => { $scope.upd = cb[0]; $scope.$apply();});
});
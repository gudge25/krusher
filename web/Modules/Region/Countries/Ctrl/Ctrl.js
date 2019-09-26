crmUA.controller('CountryCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regCountryViewModel($scope,$filter,$translate,$rootScope);
    $scope.model = {};
});
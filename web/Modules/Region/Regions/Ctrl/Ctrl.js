crmUA.controller('RegionCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regRegionViewModel($scope,$filter,$translate,$rootScope);
});
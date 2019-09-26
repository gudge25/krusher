crmUA.controller('RouteIncNewCtrl', function($scope,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astRouteIncViewModel($scope, $filter);
    $scope.new = new astRouteIncModel('').put();
});

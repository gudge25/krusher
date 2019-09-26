crmUA.controller('RouteOutCtrlNew', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astRouteOutViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astRouteOutModel('').put();
});
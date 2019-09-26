crmUA.controller('TimeGroupCtrlNew', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astTimeGroupViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astTimeGroupModel('').put();
});
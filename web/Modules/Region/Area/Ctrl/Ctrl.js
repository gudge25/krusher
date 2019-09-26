crmUA.controller('AreaCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new regAreaViewModel($scope,$filter,$translate,$rootScope);
});
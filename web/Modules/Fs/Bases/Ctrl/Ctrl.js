crmUA.controller('fsBasesCtrl', function($scope, $filter) {
    $scope.manyAction =  new fsBasesViewModel($scope, $filter);
    $scope.model = new fsBasesModel('').postFind();
});
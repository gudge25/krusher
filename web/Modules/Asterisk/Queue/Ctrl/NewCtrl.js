crmUA.controller('QueueNewCtrl', function($scope,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astQueueViewModel($scope, $filter);
    $scope.new = new astQueueModel('').put();
});

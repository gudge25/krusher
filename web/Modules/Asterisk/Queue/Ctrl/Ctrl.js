crmUA.controller('QueueCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astQueueViewModel($scope, $filter);
    $scope.model = new astQueueModel('').postFind();
    $scope.manyAction.Find();
});
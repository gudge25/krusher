crmUA.controller('TTSCtrl', function($scope ,$filter, $translate, $translatePartialLoader) {
     $scope.manyAction =  new astTTSViewModel($scope, $filter);
     $scope.model = new astTTSModel('').postFind();
});
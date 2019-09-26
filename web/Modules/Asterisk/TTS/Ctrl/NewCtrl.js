crmUA.controller('TTSNewCtrl', function($scope,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astTTSViewModel($scope, $filter);
    $scope.new = new astTTSModel('').put();
});

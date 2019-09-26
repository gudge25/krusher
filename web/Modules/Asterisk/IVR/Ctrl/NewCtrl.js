crmUA.controller('IVRNewCtrl', function($scope,$filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astIVRViewModel($scope, $filter);
    $scope.new = new astIVRModel('').put();
});

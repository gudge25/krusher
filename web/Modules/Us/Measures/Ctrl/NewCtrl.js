crmUA.controller('MeasuresNewCtrl', function($scope,$filter) {
    $scope.manyAction =  new usMeasuresViewModel($scope, $filter);
    $scope.new = new usMeasuresModel('').put();
});
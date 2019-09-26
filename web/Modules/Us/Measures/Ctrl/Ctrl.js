crmUA.controller('MeasuresCtrl', function($scope ,$filter) {
    $scope.manyAction =  new usMeasuresViewModel($scope, $filter);
    $scope.model = new usMeasuresModel('').postFind();
});
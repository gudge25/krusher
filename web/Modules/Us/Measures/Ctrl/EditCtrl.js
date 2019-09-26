crmUA.controller('MeasuresEditCtrl', function($scope, $filter, $stateParams) {
    $scope.manyAction =  new usMeasuresViewModel($scope, $filter);
    var msID = $stateParams.msID;
    new usMeasuresSrv().getFind({msID},cb => {
                $scope.upd=cb[0];
                $scope.$apply();
    });
});
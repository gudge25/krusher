crmUA.controller('TemplatesEditCtrl', function($scope, $filter, $stateParams, $compile, printForm, $rootScope,$translate ) {
    $scope.manyAction =  new dcTemplatesViewModel($scope,$filter,$translate,$rootScope);
    var id = $stateParams.dtID;

    new dcTemplatesSrv().getFind( { dctID : $stateParams.dctID },cb => {
        angular.forEach(cb, todo => {
            if( id == todo.dtID) {
                $scope.upd=todo;
                //$scope.upd= new dcTemplatesModel(todo).put();
                $scope.$apply();
            }
        });
    });
});
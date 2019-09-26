crmUA.controller('CallsCtrl', function($scope, $filter, Auth) {

    $scope.manyAction =  new CallsReportViewMode($scope, $filter);
    $scope.Auth = Auth.FFF;
    //$scope.emID = Auth.FFF.emID.toString();

    new emEmployeeSrv().getFind({},cb   => { $scope.employees   = cb; $scope.$apply();});

    $scope.model    = new emEmployeeCallsModel('').post();
    $scope.model2   = new emEmployeeStatusModel('').post();
       $scope.getForms = model => {
        if(model)
            new emEmployeeCallsSrv().ins( model, cb => {
                $scope.stats = cb;
                $scope.$apply();
            });

           if(model)
               new emEmployeeStatusSrv().getFind( model, cb => {
                   $scope.stats2 = cb;
                   $scope.$apply();
               });
        };

    $scope.getForms($scope.model);
});
crmUA.controller('emSettingsCtrl', function($scope, $filter) {
    console.log("SETTINGS");

    new emEmployeeExSrv().getAll(cb => { $scope.data = cb; $scope.$apply();});

    $scope.data = new emEmployeeCallsModel('').post();


    $scope.save = a => {
        new emEmployeeExSrv().ins(a);
    };
});
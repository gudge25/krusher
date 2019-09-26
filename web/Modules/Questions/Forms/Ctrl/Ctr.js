crmUA.controller('fmFormCtrl', function($scope, $stateParams ) {
    new fmFormItemsSrv().getFind({ dcID : $stateParams.dcID }, cb => { $scope.answer 	= cb; $scope.$apply(); });
    new fmFormsSrv().getFind({ dcID : $stateParams.dcID }, 	cb => { $scope.form 	= cb[0]; $scope.$apply(); });
});
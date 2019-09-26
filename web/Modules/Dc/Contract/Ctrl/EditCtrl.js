crmUA.controller('ContractEditCtrl', function($scope, $filter, Auth,$timeout,$uibModal,$stateParams) {
    $scope.manyAction =  new InvoiceViewModel($scope, $filter);

    let dcID = $stateParams.dcID;
    new ContractSrv().getFind({dcID},cb => {$scope.Contract = new ContractModel(cb).get();});

    $scope.uiSelectSetClass = () => {
      let selects = angular.element(document.querySelectorAll("div.normal.ui-select-container.ui-select-bootstrap.dropdown"));
      selects.addClass('submited');
    };

    $scope.cancel = () => {
      new ContractSrv().getFind({dcID},cb => { $scope.Contract = new ContractModel(cb).get();});
    };

    $scope.DeleteContract = url => {
      new ContractSrv().del(dcID);
        window.location = `/#!/${url}`;
    };
});
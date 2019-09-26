crmUA.controller('ContractCtrl', function($scope, $filter, Auth,$timeout,$uibModal) {
    $scope.manyAction =  new ContractViewModel($scope, $filter);

    $scope.Contract = new ContractModel('').post();
    $scope.Contract.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');

    $scope.formClassInvalid = 'normal';

    $scope.uiSelectSetClass = () => {
      let selects = angular.element(document.querySelectorAll("div.normal.ui-select-container.ui-select-bootstrap.dropdown"));
      selects.addClass('submited');
    };

    $scope.cancel = () => {
      $scope.Contract = new ContractModel('').post();
      $scope.Contract.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');
    };
});
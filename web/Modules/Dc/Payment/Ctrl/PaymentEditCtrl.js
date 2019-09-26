crmUA.controller('PaymentEditCtrl', function($scope, $filter, Auth,NgTableParams,$timeout,$uibModal,$stateParams) {
    $scope.manyAction =  new PaymentViewModel($scope, $filter);

    let id = $stateParams.payID;
    new pchPaymentSrv().getFind( { payID : id},cb => {
      $scope.payment = cb;
      $scope.payment.dcDisplayLink = 'Счет' + ' №'+ ' РХ-' + $scope.payment.dcLink;
      $scope.payment.dcType = 6;
    });

    $scope.uiSelectSetClass = () =>  {
      let selects = angular.element(document.querySelectorAll("div.normal.ui-select-container.ui-select-bootstrap.dropdown"));
      selects.addClass('submited');
    };

    new dcDocsTypesSrv().getFind({},    cb => $scope.docsTypes = cb);

    $scope.cancel = () =>  {
      new pchPaymentSrv().getFind( { payID : id},cb => {$scope.payment = new pchPaymentModel(cb).get();});
    };

    $scope.DeletePayment = url => {
      new pchPaymentSrv().del(id);
        window.location = `/#!/${url}`;
    };
});

crmUA.controller('PaymentCtrl', function($scope, $filter, Auth,$timeout,$uibModal,$stateParams) {
    $scope.manyAction =  new PaymentViewModel($scope, $filter);

    $scope.payment = new pchPaymentModel('').put();
    if ($stateParams.dcID !== undefined){
      var id = $stateParams.dcID;
      new sfInvoiceSrv().getFind( { invID : id},cb => {
        // let invoice = new sfInvoiceModel(cb).get();
        // let invoice = cb;
        $scope.payment.emID         =   cb.emID;
        $scope.payment.clID         =   cb.clID;
        $scope.payment.dcComment    =   cb.dcComment;
        $scope.payment.dcSum        =   cb.dcSum;
        $scope.payment.clName       =   cb.clName;
        $scope.payment.dcLink       =   cb.dcID;
        $scope.payment.dcLinkDate   =   cb.dcDate;
        $scope.payment.dcLinkNo     =   cb.dcNo;
        $scope.payment.dcLinkType   =   'Счёт';

        $scope.payment.dcDisplayLink = (($scope.payment.dcLinkType ? $scope.payment.dcLinkType+' ' : '')+
           ($scope.payment.dcLinkNo ? ' №'+$scope.payment.dcLinkNo : '')+($scope.payment.dcLinkDate ?
            ' от '+ $scope.payment.dcLinkDate : ''));

        $scope.$apply();
      });
      new sfInvoiceItemsSrv().getFind( { invID : id},cb => {$scope.paymentItems = cb;});
    }

    $scope.payment.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');
    $scope.formClassInvalid = 'normal';

    $scope.uiSelectSetClass = () =>  {
      let selects = angular.element(document.querySelectorAll("div.normal.ui-select-container.ui-select-bootstrap.dropdown"));
      selects.addClass('submited');
      $scope.payment.CreatedBy = Auth.FFF.emID;
    };

    new emEmployeeSrv().getFind({}, cb => $scope.Employees = cb);
    new dcDocsTypesSrv().getFind({},    cb => $scope.docsTypes = cb);


    $scope.cancel = () =>  {
      $scope.payment = new pchPaymentModel('').post();
      $scope.payment.CreatedBy = Auth.FFF.emID;
      $scope.payment.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');
    };

    $scope.close = () => {
      if (window.location.hash.indexOf('PaymentCreate') !== -1){
        window.location.hash = '#!/Invoice/'+ $stateParams.dcID;
      }
    };
});
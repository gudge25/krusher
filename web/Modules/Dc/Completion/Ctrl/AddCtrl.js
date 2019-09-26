crmUA.controller('CompletionAddCtrl', function($scope, $filter, Auth, $stateParams, $uibModal,$timeout,printForm) {
    $scope.manyAction =  new CompletionViewModel($scope, $filter);

    $scope.Completion = new CompletionModel('').post();
    if (window.location.hash === '#!/Completion'){
      $scope.showBtn = true;
      let dcNo = $scope.Completion.dcNo;
      let dcID = $scope.Completion.dcID;
            //default emID

      new dcTemplatesLookupSrv().get(8, cb =>  { $scope.Templates  = cb; $scope.$apply();});

      let isTransfer = new CompletionSrv().isTransfer;
      $scope.Completion               = new CompletionSrv().invoice;
      var invoiceDcID                 = new CompletionSrv().invoice.dcID;
      $scope.Completion.dcDisplayLink = $scope.Completion.dcNo + ' от ' + $scope.Completion.dcDate;
      $scope.Completion.dcNo          = dcNo;
      $scope.Completion.dcID          = dcID;
      $scope.CompletionItems          = new CompletionSrv().invoiceItems;

    }

    $scope.getSum = invoiceItems => {
      $scope.Completion.dcSum = $scope.manyAction.BaseSum(invoiceItems).Sum;
    };

    $scope.cancel = () => {
      $scope.Completion       = new CompletionModel('').post();
      $scope.CompletionItems  = [];
    };

    $scope.enumsResult = $scope.EnumsGroup[10];

    //default dcStatus
    $scope.Completion.dcStatus = $scope.enumsResult[1].p.tvID;

    $scope.ProductNames = [];
    new stProductFindSrv().getFind('', cb => { $scope.Products = cb;
      angular.forEach($scope.Products,item => $scope.ProductNames.push(item.psName) );
      $scope.$apply();
      $scope.$watch('CompletionItems[CompletionItems.length -1].psName', (newVal, oldVal) => {
          if($scope.ProductNames.indexOf(newVal) !== -1){
            angular.forEach($scope.Products,product => {
              if(product.psName === newVal)
                $scope.CompletionItems[$scope.CompletionItems.length -1].psID = product.psID;
            });
          }
          if($scope.uiSelectClassValidation.dirty){
            $scope.uiSelectClassValidation.class =
             (($scope.CompletionItems[$scope.CompletionItems.length -1].psName.length > 0)&&($scope.CompletionItems[$scope.CompletionItems.length -1] !== undefined)) ? 'normal' : 'invalid-ui-select';
          }
          if((($scope.CompletionItems[$scope.CompletionItems.length -1] !== undefined)&&($scope.CompletionItems[$scope.CompletionItems.length -1].psName)) ||
            ($scope.CompletionItems.length === 0)){
            $scope.uiSelectClassValidation.valid = true;
          }else{
            $scope.uiSelectClassValidation.valid = false;
          }
      }, true);

    });
    if (!$scope.CompletionItems) $scope.CompletionItems = [];
    let iNo =1;
    //$scope.CompletionItem = new CompletionItemsModel('').post();
    $scope.addCompletionItem = () => {
        let newCompletionItem = new CompletionItemsModel('').post();
        // let newCompletionItem = {};
        newCompletionItem.iNo = iNo;
        iNo ++;
      $scope.CompletionItems.push(newCompletionItem);
    };

    $scope.delCompletionItem = item => {
        $scope.CompletionItems.splice(item.iNo-1, 1);
        iNo =1;
        angular.forEach($scope.CompletionItems, value => {
            value.iNo = iNo;
            iNo ++;
        });
    };

     $scope.PostCompletionItems = (inv,url) => {
      if(inv.Delivery === undefined)    inv.Delivery  = null;
      $scope.manyAction.Save(inv,url);
      if($scope.CompletionItems.length){
        angular.forEach($scope.CompletionItems, value => {
          value.iName = value.psName;
          value.dcID = $scope.Completion.dcID;
          let inv = new CompletionItemsModel(value).post();
          new CompletionItemsSrv().ins(inv);
        });
      }
    };

    $scope.open = dtID => {
      printForm.setData($scope.Completion);
      printForm.setProducts($scope.CompletionItems);
      var modalInstance = $uibModal.open({
          templateUrl:  `${Gulp}Dc/Templates/Views/TemplatesEdit.html`,
          controller: 'TemplatesPreViewCtrl',
          resolve     : {
                          ModalItems: () => {
                            return {"dctID": 8, "dtID": dtID};
                          }
          }
      });
    };

    $scope.close = () => {
      if(window.location.hash === '#!/Completion') window.location.hash = '#!/Invoice/'+invoiceDcID;
    };
});
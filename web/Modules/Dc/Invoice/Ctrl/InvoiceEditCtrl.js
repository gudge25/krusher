crmUA.controller('InvoiceEditCtrl', function($scope, $filter, Auth, $stateParams, $uibModal,  $http, printForm) {
    $scope.manyAction =  new InvoiceViewModel($scope, $filter);
    $scope.manyActionInvoiceItems = new InvoiceItemsViewModel($scope,$filter);

    $scope.auth = Auth.FFF;
    $scope.formClassInvalid = null;
    $scope.dtID             = null;
    var id                  = $stateParams.invID;

    new dcTemplatesSrv().getFind({ dcTypeID : 5}, cb => { $scope.Templates  = cb; $scope.$apply(); });
    new sfInvoiceSrv().getFind( { invID : id},        cb => {
        $scope.invoice = new sfInvoiceModel(cb[0]).get();

        $scope.invoice.dcDisplayLink = (($scope.invoice.dcLinkType ? $scope.invoice.dcLinkType+' ' : '')+
         ($scope.invoice.dcLinkNo ? ' №'+$scope.invoice.dcLinkNo : '')+($scope.invoice.dcLinkDate ?
          (' от '+ ($filter('date')($scope.invoice.dcLinkDate,'dd.MM.yyyy'))) : ''));

        new sfInvoiceItemsSrv().getFind( { invID : id},cb => {$scope.invoiceItems = cb ;
            new stProductFindSrv().getFind('',cb => { $scope.Products = cb; $scope.$apply(); });
            new crmClientFindSrv().getFind( { clID : $scope.invoice.clID}  , cb => {$scope.invoice.clName = cb.clName;});
            $scope.InvoiceItemsIDs = [];
            angular.forEach(cb,  value => {
                $scope.InvoiceItemsIDs.push(value.iiID);
            });
            $scope.$watch('invoiceItems[invoiceItems.length -1].iName', (newVal, oldVal) => {
                      if($scope.ProductNames.indexOf(newVal) !== -1){
                        angular.forEach($scope.Products,product => {
                          if(product.iName === newVal)
                            $scope.invoiceItems[$scope.invoiceItems.length -1].psID = product.psID;
                        });
                      }
                      if($scope.uiSelectClassValidation.dirty){
                        $scope.uiSelectClassValidation.class =
                        (($scope.invoiceItems[$scope.invoiceItems.length -1].iName.length > 0)&&($scope.invoiceItems[$scope.invoiceItems.length -1] !== undefined)) ? 'normal' : 'invalid-ui-select';
                      }
                      if((($scope.invoiceItems[$scope.invoiceItems.length -1] !== undefined)&&($scope.invoiceItems[$scope.invoiceItems.length -1].iName)) ||
                        ($scope.invoiceItems.length === 0)){
                        $scope.uiSelectClassValidation.valid = true;
                    }else{
                      $scope.uiSelectClassValidation.valid = false;
                    }
            }, true);
        });

        $scope.TransferInvoice = () => {
          CompletionSrv.prototype.invoice       = $scope.invoice;
          CompletionSrv.prototype.invoiceItems  = $scope.invoiceItems;
          CompletionSrv.prototype.isTransfer    = true;
          window.location = `/#!/Completion`;
        };
    });

    $scope.getSum = invoiceItems =>{
      $scope.invoice.dcSum = $scope.manyAction.BaseSum(invoiceItems).Sum;
    };

    $scope.invoiceItemsIDsForDelete = [];

    $scope.refreshProducts = () => {
      $scope.ProductNames = [];
        new stProductFindSrv().getFind('', cb => { $scope.Products = cb;
        angular.forEach($scope.Products,item => {
          $scope.ProductNames.push(item.psName);
        });
      });
      $scope.$apply();
    };

    $scope.enumsResult = $scope.EnumsGroup[10];

    $scope.ProductNames = [];
    new stProductFindSrv().getFind('', cb => { $scope.Products = cb;
      angular.forEach($scope.Products,item => {
          $scope.ProductNames.push(item.psName);
      });
    });

    $scope.addInvoiceItem = () => {
        let iNo = $scope.invoiceItems.length +1;
        let newInvoiceItem = {};
        newInvoiceItem.iNo = iNo;
        iNo ++;
      $scope.invoiceItems.push(newInvoiceItem);
    };

    $scope.delInvoiceItem = item => {
        $scope.invoiceItemsIDsForDelete.push(item.iiID);
        $scope.invoiceItems.splice(item.iNo-1, 1);
        iNo =1;
        angular.forEach($scope.invoiceItems, value => {
            value.iNo = iNo;
            iNo ++;
        });
    };

    $scope.DeleteInvoice = url => {
      new sfInvoiceSrv().del($scope.invoice.dcID);
        window.location.hash = '#!/searchDocuments';
    };

    $scope.PostInvoiceItems = (inv,url) => {
      if(inv.VATSum   === undefined || inv.VATSum   === null)    inv.VATSum    = 0;
      if(inv.Delivery === undefined)    inv.Delivery  = null;
      $scope.manyAction.Update(inv,url);
      //remove invoice items
      angular.forEach($scope.invoiceItemsIDsForDelete,  value => {
            new sfInvoiceItemsSrv().del(value);
        });

      if($scope.invoiceItems.length){
        angular.forEach($scope.invoiceItems, value => {
          value.dcID    = $stateParams.invID;
          if (Boolean(value.iName) === false) value.iName = value.psName;
          let inv     = new sfInvoiceItemsModel(value).post();
          inv.HIID    = value.HIID;
          delete inv.isToday;
          if($scope.InvoiceItemsIDs.indexOf(value.iiID) !== -1 ){
            new sfInvoiceItemsSrv().upd(inv);
          }else{
            new sfInvoiceItemsSrv().ins(inv);
          }
        });
      }
    };

    $scope.open = dtID => {
      printForm.setData($scope.invoice);
      printForm.setProducts($scope.invoiceItems);
      var modalInstance = $uibModal.open({
          templateUrl:  `${Gulp}Dc/Templates/Views/TemplatesEdit.html`,
          controller: 'TemplatesPreViewCtrl',
          resolve     : {
                          ModalItems: () => {
                            return {"dctID": 5, "dtID": dtID};
                        }
          }
      });
    };
});
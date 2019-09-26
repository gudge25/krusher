crmUA.controller('InvoiceAddCtrl', function($scope, $filter, Auth, $stateParams, $uibModal,$timeout) {
    
    console.log(`InvoiceAddCtrl`); 
    $scope.manyAction = new InvoiceViewModel($scope, $filter);
    $scope.new    = new sfInvoiceModel('').post();
    if($stateParams.dcID !== undefined) {
      var dcID      = $stateParams.dcID;

      new slDealSrv().getFind({ dcID },cb => {
        console.log(cb);
        $scope.deal                   = cb[0];
        $scope.new.dcNoL          = cb[0].dcNo;
        $scope.new.dcDateL        = cb[0].dcDate;
        $scope.new.dcLink         = cb[0].dcID;
        $scope.new.dcComment      = cb[0].dcComment;
        $scope.new.dcSum          = cb[0].dcSum;
        $scope.new.clName         = cb[0].clName;
        $scope.new.emID           = cb[0].emID;
        $scope.new.clID           = cb[0].clID;
        $scope.new.dcDisplayLink  = ($scope.new.dcNoL ? $scope.new.dcNoL : '')+($scope.new.dcDateL ?
          (' от '+ ($filter('date')($scope.new.dcDateL,'dd.MM.yyyy HH:mm:ss'))) : '');
        $scope.$apply();
      });
      new slDealItemsSrv().getFind({dcID }, cb => {
        cb.forEach((item,index) => {item.iNo = index + 1;item.iName = item.psName;});
        $scope.Items   = cb;
        $scope.new.dcSum  = $scope.manyAction.BaseSum(cb).Sum;
      });
    } else $scope.Items = [];
    $scope.getSum = Items => {
      $scope.new.dcSum = $scope.manyAction.BaseSum(Items).Sum;
    };

    $scope.cancel = () => {
      $scope.Items = [];
    };
    $scope.enumsResult = $scope.EnumsGroup[10];

    //default dcStatus
    $scope.new.dcStatus = $scope.enumsResult[1].tvID;

    $scope.ProductNames = [];
    new stProductFindSrv().getFind({}, cb => { $scope.Products = cb;
      angular.forEach($scope.Products,item => $scope.ProductNames.push(item.psName) );
    });
    $scope.addInvoiceItem = () => {
        var iNo = $scope.Items.length + 1;
        let newInvoiceItem = new sfInvoiceItemsModel('').post();
        // let newInvoiceItem = {};
        newInvoiceItem.iNo = iNo;
        iNo ++;
        $scope.Items.push(newInvoiceItem);
    };

    $scope.delInvoiceItem = item => {
        $scope.Items.splice(item.iNo-1, 1);
        iNo =1;
        angular.forEach($scope.Items, (value, key) =>{
            value.iNo = iNo;
            iNo ++;
        });
    };

    $scope.PostInvoiceItems = (inv,url) => {
      //if(inv.VATSum   === undefined || inv.VATSum   === null)    inv.VATSum    = 0;
      //if(inv.Delivery === undefined)  inv.Delivery  = null;
      $scope.manyAction.Save(inv,url);
      if($scope.Items.length){
        angular.forEach($scope.Items, function(value, key){
          value.iName = value.psName;
          value.dcID = $scope.new.dcID;
          // value.psID = value.Product.psID;
          let inv = new sfInvoiceItemsModel(value).post();
          new sfInvoiceItemsSrv().ins(inv);
        });
      }
    };

    $scope.close = () => {
      if(window.location.hash === "#!/Invoice") window.location.hash = "#!/searchDocuments";
    };
});
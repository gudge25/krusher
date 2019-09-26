crmUA.controller('CompletionEditCtrl', function($scope, $filter, Auth, $stateParams, $uibModal, $http) {
    $scope.manyAction =  new CompletionViewModel($scope, $filter);
    $scope.manyActionCompletionItems = new CompletionItemsViewModel($scope,$filter);

    $scope.formClassInvalid = null;
    var id = $stateParams.dcID;
    new CompletionSrv().get(id,cb => {$scope.Completion = new CompletionModel(cb).get();

    $scope.Completion.dcDisplayLink = (($scope.Completion.dcLinkType ? $scope.Completion.dcLinkType+' ' : '')+
         ($scope.Completion.dcLinkNo ? ' №'+$scope.Completion.dcLinkNo : '')+($scope.Completion.dcLinkDate ?
          (' от '+ ($filter('date')($scope.Completion.dcLinkDate,'dd.MM.yyyy HH:mm:ss'))) : ''));

    new CompletionItemsSrv().get(id,cb => {$scope.CompletionItems = cb ;

    new stProductSrv().getAll( cb => { $scope.Products = cb;});
    new crmClientSrv().get($scope.Completion.clID , cb => {$scope.Completion.clName = cb.clName;});
        $scope.CompletionItemsIDs = [];
        angular.forEach(cb, todo => $scope.CompletionItemsIDs.push(todo.iiID) );

        $scope.$watch('CompletionItems[CompletionItems.length -1].iName', (newVal, oldVal) => {
              if($scope.ProductNames.indexOf(newVal) !== -1){
                angular.forEach($scope.Products,product => {
                  if(product.iName === newVal)
                    $scope.CompletionItems[$scope.CompletionItems.length -1].psID = product.psID;
                });
              }
              if($scope.uiSelectClassValidation.dirty){
                $scope.uiSelectClassValidation.class =
                (($scope.CompletionItems[$scope.CompletionItems.length -1].iName.length > 0)&&($scope.CompletionItems[$scope.CompletionItems.length -1] !== undefined)) ? 'normal' : 'invalid-ui-select';
              }
              if((($scope.CompletionItems[$scope.CompletionItems.length -1] !== undefined)&&($scope.CompletionItems[$scope.CompletionItems.length -1].iName)) ||
                ($scope.CompletionItems.length === 0)){
                $scope.uiSelectClassValidation.valid = true;
            }else{
              $scope.uiSelectClassValidation.valid = false;
            }
        }, true);

      });
    });

    $scope.CompletionItemsIDsForDelete = [];

    $scope.enumsResult = $scope.EnumsGroup[1013];

    $scope.ProductNames = [];
    new stProductSrv().getAll( cb => { $scope.Products = cb;
      angular.forEach($scope.Products,item => {
          $scope.ProductNames.push(item.psName);
      });
    });

    $scope.addCompletionItem = () => {
        let iNo = $scope.CompletionItems.length +1;
        let newCompletionItem = {};
        newCompletionItem.iNo = iNo;
        iNo ++;
      $scope.CompletionItems.push(newCompletionItem);
    };

    $scope.delCompletionItem = item => {
        $scope.CompletionItemsIDsForDelete.push(item.iiID);
        $scope.CompletionItems.splice(item.iNo-1, 1);
        iNo =1;
        angular.forEach($scope.CompletionItems, value => {
            value.iNo = iNo;
            iNo ++;
        });
    };

    $scope.DeleteCompletion = url => {
      new CompletionSrv().del($scope.Completion.dcID);
        window.location = `/#!/${url}`;
    };

    $scope.PostCompletionItems = (inv,url) => {
       $scope.manyAction.Update(inv,url);
      //remove Completion items
      angular.forEach($scope.CompletionItemsIDsForDelete, value => {
            new CompletionItemsSrv().del(value);
        });
      if($scope.CompletionItems.length){
        angular.forEach($scope.CompletionItems, value => {
          value.dcID = $scope.Completion.dcID;
          value.psName = value.iName;
          if($scope.CompletionItemsIDs.indexOf(value.iiID) !== -1 ){
          let inv = new CompletionItemsModel(value).put();
            new CompletionItemsSrv().upd(inv);
          }else{
            let inv = new CompletionItemsModel(value).post();
            new CompletionItemsSrv().ins(inv);
          }
        });
      }
    };
});
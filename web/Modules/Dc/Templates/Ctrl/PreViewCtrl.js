crmUA.controller('TemplatesPreViewCtrl', function($scope, $filter, $stateParams, $compile, $sce, printForm, ModalItems, $translate, $rootScope) {
    $scope.manyAction =  new dcTemplatesViewModel($scope,$filter,$translate,$rootScope);
   // new dcTemplatesSrv().getFind({ dctID : 2 }, cb =>  { $scope.Templates  = cb; $scope.$apply();});

    //if Deal
    if(ModalItems.dctID === 2){
        let id = ModalItems.dtID;//$stateParams.dtID;
        new dcTemplatesSrv().getFind({ dctID : ModalItems.dctID },cb => {
            angular.forEach(cb, todo => {
                if( id == todo.dtID) {
                    //$scope.upd = $sce.trustAsHtml(todo);

                     $scope.upd=todo;
                    $scope.$apply();
                }
            });
        });
    }
    // let id;
    // let dctID;
    // if (ModalItems){
    //     id = ModalItems.dtID;
    //     dctID = ModalItems.dctID;
    // }

    // new dcTemplatesSrv().getFind({ dctID },cb => {
    //     console.log(222);
    //     angular.forEach(cb, todo => {
    //         if( id == todo.dtID) {
    //             $scope.upd=todo;
    //             $scope.$apply();
    //         }
    //     });
    // });
    $scope.docs     = printForm.getData();
    $scope.products = printForm.getProducts();
    $scope.deal     = printForm.getDeal();
    
    // $scope.Summ = $scope.manyAction.BaseSum($scope.products);
    // console.log(Summ);
    //if ACT
    // if ($scope.docs !== null && $scope.docs.dcNo && $scope.docs.dcNo.indexOf('ОУ') !== -1) {
    //     var clID = $scope.docs.clID;

    //     new crmClientFindSrv().getFind({clID},    cb => {
    //         $scope.client     = cb;
    //         if (!cb.isPerson) {
    //             new crmClientParentSrv().get(cb.clID,cb => {
    //                 $scope.Parents = cb;
    //                 $scope.Parents.forEach( item => {
    //                     if (item.IsPerson) {
    //                         if (item.Position === 101202) {$scope.positionCeo = 'Ген. Директор'; $scope.parentNameCeo = item.clName;}
    //                         if (item.Position === 101201) {$scope.positionDir = 'Директор'     ; $scope.parentNameDir = item.clName;}
    //                     }
    //                 });
    //                 $scope.$apply();
    //             });
    //         }
    //         $scope.$apply();
    //     });
    //     new orgSrv().getFind({clID},              cb => {$scope.Org        = cb[0];  $scope.$apply();});
    //     new crmContactSrv().getFind({clID},   cb => {$scope.contacts   = cb;  $scope.$apply();});
    //     new crmAddressSrv().getFind({clID},   cb => {$scope.address    = cb;  $scope.$apply();});
    // }
});
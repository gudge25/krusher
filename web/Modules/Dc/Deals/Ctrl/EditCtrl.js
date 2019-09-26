crmUA.controller('DealEditCtrl', function($scope, $filter,$stateParams,$uibModal,printForm,$translate,$rootScope) {
    $scope.manyAction =  new slDealViewModel($scope,$filter,$translate,$rootScope);
    var dcID = $stateParams.dcID;
    new slDealSrv().getFind({ dcID },cb => {
            if(cb.length > 0){
                //console.log(cb)
                $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply();

                new crmClientFindSrv().getFind({ clID : $scope.upd.clID}, cb => { $scope.client = cb[0]; $scope.$apply();});
                new slDealItemsSrv().getFind({ dcID }, cb => { $scope.upd2 = cb; $scope.upd_old2 = angular.copy(cb); $scope.$apply(); $scope.Sum(); });
                
                if($scope.upd.dcLink) //new dcDocClientSrv().getFind({ dcID : $scope.upd.dcLink }, cb => { $scope.DcLink = cb; $scope.$apply(); });
                    new ccContactSrv().getFind({ dcIDs : [{dcID:$scope.upd.dcLink}]}, cb => {
                        $scope.DcLink = cb; $scope.$apply();
                    });

                new dcTemplatesSrv().getFind({ dctID : 2 }, cb =>  { $scope.Templates  = cb; $scope.$apply();});
            } else  window.location = "#!/page404";
    });

    $scope.addItems = () =>{
        if(!$scope.upd2) $scope.upd2 = []; 
        var p = new slDealItemsModel('').put();
        p.dcID = $stateParams.dcID;
        $scope.upd2.push(p);
        $scope.Sum();
    };

    $scope.open = dtID => {
        printForm.setDeal($scope.upd);
        printForm.setData($scope.client);
        printForm.setProducts($scope.upd2);
        var modalInstance = $uibModal.open({
            templateUrl:  `${Gulp}Dc/Templates/Views/Print.html`,
            controller: 'TemplatesPreViewCtrl',
            windowClass : 'xx-dialog',
            resolve     : {
                            ModalItems: () => {
                              return {"dctID": 2, "dtID": dtID};
                          }
            }
          });
        };
});
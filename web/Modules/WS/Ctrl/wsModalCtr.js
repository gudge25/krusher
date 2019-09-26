crmUA.controller('wsModalCtr', function ($scope, $uibModalInstance, contact, $filter, Auth) {
    const Client  = angular.element(document.getElementById('wsPopupCtrl')).scope();
    angular.element(document.querySelector(".modal-content")).removeClass("modal-content");

	$scope.manyAction =  new wsViewModel($scope, $filter);

	[$scope.Auth,$scope.contacts] = [Auth.FFF,contact];

    $scope.ExSave = e => {
        //console.log(`FFFFFF`);
        e.Loading = true;
        new crmClientExSrv().getFind({ clID : e.clID, limit: 1 }, cb => {
            if(cb.length > 0){
                let copy = Object.assign({}, e);
                copy.HIID = cb[0].HIID;
                new crmClientExSrv().upd(copy, cb => { e.Loading = false; console.log(`done update`);  $scope.$apply(); });
            } else {
                 new crmClientExSrv().ins($scope.client, cb => { e.Loading = false; console.log(`done create`);  $scope.$apply(); });
            }
        });
    };

    $scope.GetClient = () => {
        // if($scope.contacts[0])
        // angular.forEach($scope.contacts[0].clients, todo => {
        //     new orgSrv().getFind({ clID :todo.clID }, cb => {
        //          if(cb) { todo = Object.assign(todo, cb[0]); }
        //     });
        //     // new crmClientFindSrv().getFind({ clID :todo.clID }, cb => {
        //     //      if(cb) {  console.log(`client 2`);
        //     //         todo = Object.assign(todo, cb[0]); $scope.$apply(); }
        //     // });
        // });

        angular.forEach($scope.contacts, todo => {
            //console.log(todo);
            if(todo.coID){
                new crmCompanySrv().getFind({coID : todo.coID, isActive: true, limit: 1},cb => { todo.coName = cb[0].coName; todo.outMessage = cb[0].outMessage; todo.inMessage = cb[0].inMessage; $scope.$apply(); });
            }
            else {
                if(todo.source)
                    new astTrunkSrv().getFind({trName : todo.source, isActive: true, limit: 1 },cb => {
                        if(cb)
                            if(cb[0])
                                if(cb[0].coID) {
                                    todo.coID = cb[0].coID;
                                    new crmCompanySrv().getFind({coID : todo.coID, isActive: true, limit: 1 },cb => { todo.coName = cb[0].coName; todo.outMessage = cb[0].outMessage; todo.inMessage = cb[0].inMessage; $scope.$apply(); });
                                }
                    });
            }        
            //Add calling card
            console.log(`========== add CALLINGCARD =============`);
            //todo.CALLINGCARD = { ContactStatus: null,Comment: null }; todo.CALLINGCARD_old = angular.copy(todo.CALLINGCARD); 
         });
         //console.log(`========== add CALLINGCARD 2 =============`);
    };
    
    $scope.GetClient();

    //$scope.cansel = index =>  {  console.log(index); $scope.contacts.splice(index,1); console.log(`When single close`); console.log($scope.contacts); $scope.global.Loading = false;   if($scope.contacts.length === 0) { Client.PauseAll(false); $uibModalInstance.dismiss('cancel'); } };
    $scope.cansel = elem =>  { 
        $scope.contacts.forEach( (item, index, object) => {
            if (item.phone == elem.phone) {
                object.splice(index, 1);
            }
        });
        // console.log( $scope.contacts);
        $scope.global.Loading = false; if($scope.contacts.length === 0) { console.log(`Last clolse`); Client.PauseAll(false); $uibModalInstance.dismiss('cancel'); } 
    };

    $scope.Save = (a,index) => {
            $scope.global.Loading = true;
            let model = { ccNames :[a.phone], dcIDs : [{ dcID: a.dcID}], clIDs :[{ clID: a.clID }], ffIDs : [{ ffID: a.ffID }],  IsOut :a.IsOut, limit: 1};
            new ccContactSrv().getFind(model,cb => {
                if(cb.length > 0){ 
                    cb[0].ContactStatus = a.CALLINGCARD.ContactStatus;
                    cb[0].Comment = a.CALLINGCARD.Comment;
                    new ccContactSrv().upd(cb[0],() => { $scope.cansel(a); }); 
                }	
                else $scope.cansel(a);
            }); 	
    };

    $scope.Check_upd_old = (a,b) => {
         return angular.equals(a, b) ? true : false;
    };

    //COLUMNS
    // $scope.$watch('item.clients', () => {
    //     if($scope.item) if($scope.item.clients)
    //         console.log($scope.item.clients);
    // });
});
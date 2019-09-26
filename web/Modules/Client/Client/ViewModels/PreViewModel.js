class crmClientPreViewModel extends BaseViewModel {
        constructor($scope, $filter, id, Type, $translate, $rootScope) {
            super($scope, $filter, new crmClientSrv(), $translate);
            $scope.crmClientStatus  = $scope.EnumsGroup[1011];
            $scope.ClearPhone = c => {
                if(c.ccName) {
                    c.ccName.trim();
                    c.ccName = c.ccName.replace(/\D/g, "");
                    if(c.ccName.length == 10) if(c.ccName.substring(0,1) == parseInt(0)) c.ccName = `38${c.ccName}`;
                    if(c.ccName.substring(0,3) == parseInt(380)) c.ccName = c.ccName.substring(0,12);
                }
            };

            var t;
            switch(Type){
                case `Edit`     : t = `Edit`;       break;
                case `PreView`  : t = `PreView`;    break;
                default         : t = `PreView`;    break;
            }

            $scope.tabs = [
                { title:'Инфо о контакте' , content:  `<div ng-include="'/build/Client/Client/Views/${t}/Contact.html'"></div>` }
            ];

            $scope.trans = () => {
                $translate(['responsible', 'status']).then(a => {
                    if ($scope.employees.data !== undefined)  $scope.employees.data[0].emName = '- ' + a.responsible + ' -';
                });
            };
            $rootScope.$on('$translateChangeSuccess', () => {
                $scope.trans();
            });

            $scope.GetClient = () => {
                 new crmClientFindSrv().getFind({ clID :id }, cb => {
                    //console.log(cb)
                    let client = cb[0];

                    if(cb.length > 0){
                        $scope.client       = client;
                        $scope.client_old   = angular.copy(client);
                        //Org info
                        $scope.getOrg();
                        //ProductItems
                        if (Boolean(client.clID) || client.clID === 0){
                            new crmProductSrv().getFind({ clID : client.clID },cb => { $scope.Products = cb; $scope.$apply(); });
                            new stProductFindSrv().getFind({} , cb => { $scope.product   = cb; $scope.$apply();});
                        }
                        //Parent
                        if( client.ParentID !== null && client.ParentID )
                            new crmClientFindSrv().getFind({ clID : client.ParentID}, cb    => { $scope.Parent = cb[0];  $scope.$apply(); });
                        //Parent
                        if( client.clID !== null)
                            new crmClientParentSrv().get(client.clID,   cb    => { $scope.Parents = cb; $scope.$apply(); });
                    } 
                    else  
                        window.location = "#!/page404";
                });
                new ccContactSrv().getFind( { clIDs :  [ { clID : id} ]   }, cb => { $scope.cc_contacts = cb; $scope.cc_contacts_old = angular.copy(cb); $scope.$apply();});
                new crmAddressSrv().getFind({ clID :id}, cb => { $scope.address = cb; $scope.address_old = angular.copy(cb); $scope.$apply();});
                new crmResponsibleSrv().getFind({ clID : id}, cb  => { $scope.Responsible = cb; $scope.$apply(); });                               //Ответственный
            };

            $scope.GetClient();

            $scope.getOrg = () => {
                new orgSrv().getFind({ clID : id}, cb => {
                    $scope.Org = cb[0] ? cb[0] : new orgModel('').put();
                    $scope.Org_old = angular.copy(cb[0]);
                    if($scope.Org)
                    if(!$scope.Org.clID && $scope.Org.clID !== 0) {
                        $scope.Org = new orgModel('').post();
                        $scope.Org.clID = id;
                    }
                    if($scope.client.IsPerson) return;
                    $scope.tabs.push({ title: `Инфо о контрагенте`,  content:  `<div ng-include="'/build/Client/Client/Views/${t}/Org.html'"></div>`});
                });
            };

            $scope.changeTabs = isPerson => {
                if (isPerson)
                    $scope.tabs.pop();
                else
                    $scope.getOrg();
            };

            //ProductItems
            $scope.addItems = () => {
                if(!$scope.Products) $scope.Products = [];
                var p = new crmProductModel('').put();
                p.clID = id;
                $scope.Products.push(p);
                //$scope.Sum();
            };
            $scope.ItemsEdit = a => {
                angular.forEach(a, row => {
                    if(row.cpID){
                        new crmProductSrv().upd(row);
                    }else{
                        new crmProductSrv().ins(row);
                    }
                });
            };
            $scope.dellItems = a => {
                angular.forEach($scope.Products, (todo,key) => {
                    if(key == a)  {
                        $scope.Products.splice(key,1);
                        if(todo.cpID) new crmProductSrv().del(todo.cpID);
                    }
                });
            };
        }
}

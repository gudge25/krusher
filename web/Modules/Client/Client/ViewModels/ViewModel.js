class crmClientViewModel extends BaseViewModel {
        constructor($scope,$timeout,$filter, $uibModal, $translate, $rootScope)
        {
            super($scope, $filter, new crmClientSrv(), $translate);
            this.uibModal   = $uibModal;
            this.scope      = $scope;

            $scope.LoadStatus=false;

            var trans = () => {
                $translate('responsible').then(a => {
                    if ($scope.employees.data !== undefined) $scope.employees.data[0].emName = a;
                });
            };
            $rootScope.$on('$translateChangeSuccess', () => {
                trans();
            });

            new fsBasesSaBDSrv().getAll(cb =>    {
                //cb.unshift( {ffID: 0, ffName: "[Default]", isActive:true, dbName : "Ukraine"});
                $scope.BasesSaBDGroup = _.groupBy(cb, 'dbName'); $scope.$apply();});

            $scope.Clean = () => {
                delete $scope.data;  delete $scope.Summary;  //delete $scope.index;
                delete $scope.cl_status;
                $scope.Filter = {
                    "Pages": {
                        "maxSize": 5,
                        "limit": 100,
                        "CurrentPage": 1,
                        "TotalItems": 0
                    },
                    "Filter": null
                };
                $scope.hot=false;
                localStorage.removeItem('Pages');
                $scope.Pages.FFF ='';
                $scope.statusName = null;
                $scope.LoadStatus = false;
                //$scope.$apply();
                $timeout( () => {
                    $scope.$apply();
                }, 0,false);
            };

            //Local storage
            $scope.Storage = () => {
                $scope.limit=22;
                $scope.Pages.FFF = $scope.Filter;
                localStorage.setItem('Pages', JSON.stringify($scope.Filter));
            };

            //Поиск клиента
            $scope.FindClient = (a,d) => {

                $scope.checkAll = false; $scope.global.Loading=true;
                //New Model if empty

                if(!$scope.Filter.Filter) $scope.Filter.Filter  = new crmClientModel('').postFind();
                $scope.Filter.Filter.clStatus = $scope.Filter.Filter.clStatus ? parseInt($scope.Filter.Filter.clStatus) :  101;
                $scope.statusName = $scope.Filter.Filter.clStatus;

                if(a){
                    //on click add class to tag if $scope.tagNumber is
                    $scope.tagNumber =  a.tagID;
                      //on click add class to ffID if $scope.tagNumber is
                    if (a.Name !== null && a.Name !== undefined) {       $scope.statusName = a.Name;
                    } else if (a.ccStatus !== null && a.ccStatus !== undefined) { $scope.statusName = a.ccStatus;
                        } else  if (a.clStatus !== null && a.clStatus !== undefined) $scope.statusName = a.clStatus;
                }

                if($scope.Filter.Filter && $scope.x == 'start') [ $scope.Filter.Filter.ccStatus ,$scope.Filter.Filter.clStatus ] = [ null, null ];
                 //  console.log($scope.Filter.Filter)
                $scope.x = 0;

                $scope.Filter.Filter.limit   = $scope.Filter.Pages.limit;
                $scope.Filter.Filter.offset  = ($scope.Filter.Pages.CurrentPage * $scope.Filter.Filter.limit) - $scope.Filter.Filter.limit ;

                if(a) {
                    if (a.FilterID == 1004 || a.FilterID == 1003) {
                        $scope.Filter.Filter.clStatus = null;
                        $scope.Filter.Filter.ccStatus = null;
                    }
                    if (a.FilterID == 1004) $scope.Filter.Filter.clStatus = a.Name;
                    if (a.FilterID == 1003) {
                            $scope.Filter.Filter.ccStatus = a.Name;
                            $scope.Filter.Filter.clStatus  = 101;
                    }
                    //Get Page
                    if(a.Qty)$scope.Filter.Pages.TotalItems = a.Qty;
                    //find of name
                     if (a.clName) $scope.Filter.Filter.offset = null;
                }

                $scope.Filter.Filter.reverse    = $scope.reverse;
                $scope.Filter.Filter.sorting    = $scope.reverse ? `DESC` : `ASC` ;
                $scope.Filter.Filter.ffID       = $scope.Filter.ffID;
                $scope.Filter.Filter.field      = $scope.order;
                //console.log($scope.Filter.Filter)

                //CHECK BUG WITH CCSTATUS(ANSWERED&DNRINGING)
                $scope.model                    = new crmClientModel($scope.Filter.Filter).postFind();
                   // console.log( $scope.model)

                //$scope.model                    = $scope.Filter.Filter;
                //this.Find(new crmClientFindSrv());
                this.Find();

                //COLUMNS
                $scope.$watch('data', () => {
                    //console.log($scope.data);
                    $scope.ColEmail     = false;
                    $scope.ColComment   = false;
                    $scope.ColemName    = false;
                    $scope.ColCallDate  = false;
                    $scope.ColccQty     = false;
                    if($scope.data)
                        if($scope.data.length > 0)
                            $scope.data.forEach( todo => {
                                    if(todo.Email)      $scope.ColEmail     = true;
                                    if(todo.Comment)    $scope.ColComment   = true;
                                    if(todo.emName)     $scope.ColemName    = true;
                                    if(todo.CallDate)   $scope.ColCallDate  = true;
                                    if(todo.ccQty)      $scope.ColccQty  = true;
                            });
                });


                if($scope.Filter.Filter.ffID)
                    $timeout( () => {
                        $scope.$apply('Summary');
                        $scope.$apply('Filter');
                        $scope.$apply('cl_status');
                    }, 0,false);
                $scope.Storage();
            };

            //Получение статусов базы
            $scope.GetStatus = a => {
                if( ( $scope.Filter.ffID && a == $scope.Filter.ffID &&  $scope.cl_status) || $scope.LoadStatus) return -1;
                $scope.LoadStatus=true;
                [$scope.showInfo, $scope.showStatus, $scope.showDocs] = [false, false, false];
                a = a  !== undefined ? a : 0 ;
                $scope.Filter.ffID          = a;
                delete $scope.cl_status;
                delete $scope.data;
                delete $scope.Summary;
                // localStorage.removeItem('Pages');
                //check if esist FILE
                new fsFileSrv().getFind({ffID:a}, cb => {
                        if(cb.length > 0){
                              //GET STATUS
                              new fsFileSrv().get(a,  cb => {
                                $scope.cl_status        = cb;
                                $scope.LoadStatus       = false;
                                //show Status items (status,info,docs)
                                cb.forEach( value => {
                                    if ((value.FilterID==1001 && value.Qty>0) || (value.FilterID==1002 && value.Qty>0))   $scope.showInfo   = true;
                                    if ((value.FilterID==1003 && value.Qty>0) || (value.FilterID==1004 && value.Qty>0))   $scope.showStatus = true;
                                    if (value.FilterID < 100  && value.FilterID > 0 && value.Qty>0)                       $scope.showDocs   = true;
                                });
                                $scope.$apply();

                                new fsDetailSrv().ins($scope.Filter, cb => { $scope.Summary = cb;  $scope.$apply();});
                                //Auto open clien by status 101
                                $scope.FindClient($scope.Filter.Filter);
                            });
                            //new fsBasesSaBDSrv().get(a, cb => { $scope.SaBD_status   = cb; $scope.$apply(); });
                        }
                        else $scope.Clean();
                });


            };

            $scope.ChildIndex = a => {
                $scope.Filter.ChildIndex = a;
            };

            //Page & filrer settings
            var LP = JSON.parse(localStorage.getItem('Pages'));
            var x =0;
            if (!LP)
            {
                $scope.Filter = {
                    "Pages": {
                        "maxSize": 5,
                        "limit": 100,
                        "CurrentPage": 1,
                        "TotalItems": 0
                    },
                    "Filter": null,
                    "ChildIndex": 1
                };
            }
            else
            {
                $scope.Filter = LP;
                x = 1;

                $scope.order = $scope.Filter.Filter.field;
                $scope.reverse = $scope.Filter.Filter.reverse;

                $scope.GetStatus($scope.Filter.ffID);
                //$scope.FindClient($scope.Filter.Filter);
                $scope.country  = LP.BaseName;
            }

            $scope.Limit = a => {
                $scope.Filter.Filter.limit  = $scope.Filter.Pages.limit = a;
                $scope.Filter.Filter.offset = ($scope.Filter.Pages.CurrentPage * $scope.Filter.Filter.limit) - $scope.Filter.Filter.limit ;
                new crmClientSrv().getFind($scope.Filter.Filter,cb => { $scope.data = cb;  $scope.$apply();});
                $scope.Storage();
            };
        }

        manyDelNew(){
            var [d,data] = [false,this.scope.data.filter( val => val.isChecked)];
            if(!data.length) { alert('Вы ничего не выбрали!'); return; }
            let x;
            if(data !== undefined) {
                let clIDs = [];
                angular.forEach(data, todo => clIDs.push(parseInt(todo.clID)) );
                x = new crmClientSrv().postDel({ clIDs : clIDs }, () => { setTimeout(() => { console.log(`deleted ${clIDs}`); this.scope.cl_status = null; this.scope.GetStatus(this.scope.Filter.ffID); this.scope.FindClient(this.scope.Filter.Filter);  }, 500);  });
            }

            /*let x = angular.forEach(data,todo => {

            });*/
            //$.when(x).done( () => { setTimeout(() => { console.log(`done`); this.scope.GetStatus(this.scope.Filter.ffID); this.scope.FindClient(this.scope.Filter.Filter);  }, 1000); });
        }

        open(items){
            var [clientArr,c,scope] = [[],false,this.scope];
            angular.forEach(items, todo => {
                if (todo.isChecked) {
                    clientArr.push(todo);
                    c = true;
                }
            });

            if(!c) alert('Вы ничего не выбрали!');
            else {
                var uibModalInstance = this.uibModal.open({
                    templateUrl: 'build/Client/Client/Views/ManyEdit.html',
                    controller: 'crmClientCtrlManyEdit',
                    size:``,
                    resolve: {
                        items:  () => {
                            return clientArr;
                        }
                    }
                });

                uibModalInstance.result.then( () => {
                }, () => {
                    //x=1;//BUG
                    scope.FindClient(scope.Filter.Filter);
                });
            }
        }

}

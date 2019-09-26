class ActualizationViewModel extends BaseViewModel {
    SearchClient(a) {
        return super.SearchClient(a);
    }
        constructor($scope,$timeout,$filter,$uibModal)
        {
            super($scope,$filter,new crmClientSrv);
            this.uibModal   = $uibModal;
            this.scope      = $scope;

            new fsBasesSaBDSrv().getAll( cb =>    { $scope.BasesSaBDGroup   = _.groupBy(cb, 'dbName'); $scope.$apply();});

            $scope.Clean = () => {
                delete $scope.SaBD_status;
                $scope.Filter = {};
                localStorage.removeItem('Actualization');
            };

            //Local storage
            $scope.Storage = () => {
                localStorage.setItem('Actualization', JSON.stringify($scope.Filter));
            };

            //Получение статусов базы
            $scope.GetStatus = a => {
                localStorage.removeItem('Actualization');
                a = $scope.Filter.ffID;

                var Check = false;

                new fsBasesSaBDSrv().get(a, cb => {
                    $scope.SaBD_status   = cb;
                    angular.forEach($scope.SaBD_status, todo => { if(todo.FilterID == 1002 && todo.Qty >= 3)  Check = true;  });
                    $scope.$apply();
                    if( $scope.AutoHand || !Check) {
                        console.log($scope.AutoHand + ' - ' + Check);
                        new fsBasesSaBDSrv().get(a, cb => {
                            $scope.SaBD_status = cb;
                            $scope.$apply();
                        });
                    }
                    else
                        new crmResponsibleSaBDSrv().ins({ 'url' : a }, () => { new fsBasesSaBDSrv().get(a, cb => { $scope.SaBD_status   = cb; $scope.$apply(); }); });
                    $scope.Storage();
                });
            };

            //Page & filrer settings
            var LP = JSON.parse(localStorage.getItem('Actualization'));
            var x =0;
            if (!LP)
            {
                $scope.Filter = {
                };
            }
            else
            {
                $scope.Filter = LP;
                x = 1;
                $scope.GetStatus($scope.Filter.ffID);
            }
        }
}
class astQueueViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astQueueSrv());
        $scope.Strategy  = $scope.EnumsGroup[1015];
        $scope.DestType  =  $scope.EnumsGroup[1014];//.map( x => { if(x.tvID != 101406) return x; } );

        $scope.Interface = a => {
            angular.forEach($scope.employees.data, todo => {
                if(todo.emID == a.emID) {
                    a.interface = `SIP/${todo.sipName}`;
                    a.queue_name = $scope.upd.name;
                    a.membername = todo.emName;
                }
            });
        };

        // $scope.SaveMember = () => {
        //     angular.forEach($scope.Items, row => {
        //         //row.queue_name = $scope.upd.name;
        //         if(row.quemID){
        //             new astQueueMemberSrv().upd(row);
        //         }else{
        //             new astQueueMemberSrv().ins(row);
        //         }
        //     });
        // };

        // $scope.dellItems = a => {
        //     if(a.quemID) new astQueueMemberSrv().del(a.quemID, () => {
        //         new astQueueMemberSrv().getFind($scope.model, cb => { $scope.Items = cb; $scope.$apply();}); });
        // };

        $scope.Check = a => {
            var input = false;
            angular.forEach($scope.Items, todo => {
                    if(todo.emID == a.emID || a.sipName === null) input = true;
            });
            return input;
        };

        $scope.infoStrategyF = () => {
            $scope.infoStrategy = $scope.infoStrategy ? false : true;
        };
    }
}
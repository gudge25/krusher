class astIVRViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astIVRConfigSrv());
        $scope.DestType  = $scope.EnumsGroup[1014];//.map( x => { if(x.tvID != 101406) return x; } );

        // $scope.addItems = () => {
        //     if(!$scope.IVREntry) $scope.IVREntry = [];
        //     var p = new astIVRItemsModel('').put();
        //     p.id_ivr_config = $scope.upd.id_ivr_config;
        //     $scope.IVREntry.push(p);
        // };

        // $scope.SaveItem = () => {
        //     angular.forEach($scope.IVREntry, row => {
        //         if(row.entry_id){
        //             new astIVREntrySrv().upd(row);
        //         }else{
        //             new astIVREntrySrv().ins(row);
        //         }
        //     });
        // };

        // $scope.dellItems = a => {
        //     if(a.entry_id) new astIVREntrySrv().del(a.entry_id, () => {
        //         //new astIVREntrySrv().get($scope.upd.entry_id, cb => { $scope.IVREntry = cb; $scope.$apply();});
        //         new astIVREntrySrv().getFind({  id_ivr_config : a.id_ivr_config }, cb => {
        //             $scope.IVREntry = cb;
        //             $scope.IVREntry.map( x => {
        //                    x.destination = parseInt(x.destination);
        //                    return x;
        //             });
        //             $scope.$apply();});
        //     });
        // };

        $scope.Check = a => {
            var input = false;
            angular.forEach($scope.IVREntry, todo => {
                    if(todo.membername == a) input = true;
            });
            return input;
        };
    }
}
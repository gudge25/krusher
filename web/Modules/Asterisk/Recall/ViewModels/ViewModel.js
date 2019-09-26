class astRecallViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astRecallSrv());
        $scope.DestType  =  $scope.EnumsGroup[1014]; //.map( x => { if(x.tvID != 101406) return x; } );

        $scope.Check = a => {
        	if(a == `upd`){
        		if($scope.upd.RecallDaysCount == 1) $scope.upd.RecallAfterPeriod = 1;
            }
        	else {
        		if($scope.new.RecallDaysCount == 1) $scope.new.RecallAfterPeriod = 1;
            }
        };
    }
}
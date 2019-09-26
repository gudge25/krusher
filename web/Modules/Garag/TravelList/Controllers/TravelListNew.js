crmUA.controller('TravelListNewCtrl', function($scope, $filter, Auth,$stateParams) {
    var v = {
        scope: $scope,
        filter: $filter
    };

    $scope.manyAction   =  new gaTravelListViewModel(v);
    $scope.new.emID     = Auth.FFF.emID;
    $scope.new.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');

    //if add from client
    if($stateParams.dcID){
        $scope.new.clID     = $stateParams.dcID;
        new crmClientSrv().get($scope.new.clID, cb => { $scope.client = cb; $scope.$apply();  });

        $scope.new.dcLink   = $stateParams.dcID;
        new slDealSrv().get($scope.new.dcLink, cb => { $scope.Deal = cb; $scope.$apply();  });
    }

    $scope.$watchCollection('[select,select2,searchclient]', () => {
        if($scope.select) {
            $scope.new.psName   = $scope.select.psName;
            $scope.new.psID     = $scope.select.psID;
        }
        if($scope.select2) {
            $scope.new.drvName  = $scope.select2.drvName;
            $scope.new.drvID    = $scope.select2.drvID;
        }
        if($scope.searchclient) $scope.new.clID = $scope.searchclient.clID;
    });
});
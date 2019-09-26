crmUA.controller('mpMarketplaceCtrl', function($scope, $filter,$timeout) {
    $scope.manyAction =  new mpMarketplaceViewModel($scope, $filter);
    $scope.model = new mpMarketplaceModel('').postFind();

    $scope.install = a => {
        $scope.global.Loading = true;
        let model  = new mpMarketplaceInstallModel(a).put();
        delete model.HIID;
        new mpMarketplaceInstallSrv().ins(model,cb => { $scope.getAll(); });
    };

    $scope.remove = a => {
        $scope.global.Loading = true;
        angular.forEach($scope.Items,todo => {
            if(a.mpID == todo.mpID)
                new mpMarketplaceInstallSrv().del(todo.mpiID,cb => { $scope.getAll(); });
        });
    };

    $scope.getAll = () => {
        $timeout(() => {
                $scope.modelItems = { limit : 15 };
                $scope.ItemsSrv 	= new mpMarketplaceInstallSrv();
                $scope.ItemsModel 	= mpMarketplaceInstallModel;
                $scope.manyAction.Find($scope.ItemsSrv); 
                $scope.group = _.groupBy($scope.Items, 'mpID'); 
                $scope.global.Loading = false;
                $scope.$apply(); 
        },501);
    };
    $scope.getAll();

    $scope.$watch('Items', () => {
        if($scope.Items) {
            $scope.group = _.groupBy($scope.Items, 'mpID'); 
        }
    });

    $scope.Show = a => {
        let show = false;
        if($scope.group)
            if($scope.group[a.mpID]){
                if($scope.group[a.mpID].length > 0) show = true;
            }
        return show;
    };
});
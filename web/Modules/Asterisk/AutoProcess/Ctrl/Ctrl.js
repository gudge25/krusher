// crmUA.component('autoprocessctrl', {
//   bindings: {value: '<'},
//   controller: AutoProcessCtrl,
//   templateUrl: `${Gulp}Asterisk/AutoProcess/Views/All.html`,
// });
crmUA.controller('AutoProcessCtrl',  function ($scope ,$filter, $translate, $translatePartialLoader, Auth, Progress) {
    $scope.manyAction =  new astAutoProcessViewModel($scope, $filter);
    $scope.model = new astAutoProcessModel('').postFind();
	$scope.manyAction.Find();



    [$scope.auth,$scope.Progress] = [Auth,Progress];


    $scope.ProgressStart = e => {
        console.log($scope.Progress.FFF.id_autodial);
        if($scope.Progress.FFF.id_autodial){
            $scope.Progress.FFF.process = 101602;
            $scope.Progress.FFF.errorDescription = null;
            $scope.Progress.FFF.called = 0;
            new astAutoProcessSrv().upd($scope.Progress.FFF, cb => { $scope.manyAction.Find(); $scope.Progress.FFF = new astAutoProcessModel('').put();});
        }
        else {
            $scope.Progress.FFF.id_autodial = null;
            $scope.Progress.FFF.process = 101602;
            $scope.Progress.FFF.errorDescription = null;
            $scope.Progress.FFF.called = 0;
            new astAutoProcessSrv().ins($scope.Progress.FFF, cb => { $scope.manyAction.Find(); $scope.Progress.FFF = new astAutoProcessModel('').put();});
        }
    };

    $scope.ProgressStop = e => {
    	$scope.Progress.FFF.process = 101603;
    	new astAutoProcessSrv().upd($scope.Progress.FFF, cb => { $scope.manyAction.Find(); $scope.Progress.FFF = new astAutoProcessModel('').put();});
    };

    $scope.SelectAutoProccess  = e => {
        if( $scope.Progress.FFF.id_autodial === e.id_autodial)
            $scope.Progress.FFF = new astAutoProcessModel().put();
        else
            $scope.Progress.FFF = new astAutoProcessModel(e).put();
    };
});
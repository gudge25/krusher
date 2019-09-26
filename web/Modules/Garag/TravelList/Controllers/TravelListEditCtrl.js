crmUA.controller('TravelListEditCtrl', function($scope, $timeout, $filter, Auth, $stateParams) {
    var v = {
        scope: $scope,
        filter: $filter
    };

    $scope.manyAction =  new gaTravelListViewModel(v);

    var id = $stateParams.dcID;

    new gaTravelSrv().get(id, cb => { $scope.upd2 = [ cb ]; $scope.$apply();});
    new gaTravelistSrv().get(id, cb => {
        $scope.upd = cb;
        if($scope.upd.clID) new crmClientSrv().get($scope.upd.clID,cb => { $scope.client = cb; $scope.$apply();});
        if($scope.upd.psID) $scope.select = { "psID" : $scope.upd.psID,"psName" : $scope.upd.psName };
        $scope.$apply();
    });

    //Add Items
    $scope.addItems = function(){
        if(!$scope.upd2) $scope.upd2 = [];
        var p = new gaTravelModel('').put();
        p.InDate    = $filter('date')(new Date(),'yyyy-MM-dd');
        p.OutDate   = $filter('date')(new Date(),'yyyy-MM-dd');
        p.dcID      = id;
        $scope.upd2.push(p);
    };

    $scope.dellItems = function(a){
        new gaTravelSrv().del(a.trID);
        angular.forEach($scope.upd2, (todo,key) => {
            if(todo.trID == a.trID)  $scope.upd2.splice(key,1);
        });
    };

    $scope.ItemsEdit = function(a){
        angular.forEach(a, todo => {
            if (!todo.trID) new  gaTravelSrv().ins(todo); else new gaTravelSrv().upd(todo);
        });
    };

});
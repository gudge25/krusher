crmUA.controller('TapeCtrl', function($scope ,$filter ,$uibModal, $translate, $translatePartialLoader,$rootScope) {

    $scope.manyAction         =  new crmClientStreamViewModel($scope, $filter);
    $scope.manyActionComments =  new usCommentsViewModel($scope, $filter);
    $scope.comments = {};
    $scope.model = {};
    $scope.showFilter = false;
    $scope.new      = new usCommentsModel('').post();

    $scope.getComment = id => {
      new usCommentsSrv().get(id , cb => { $scope.comments[id] = cb ; $scope.$apply();});
    };

    $scope.itemToShow   = "Документы";
    $scope.GulpViewPath = Gulp;

    $scope.getData = emID => {
      if(emID === null)
        new hClientSrv().getFind({},cb => { $scope.clients = cb; $scope.$apply(); });
      else
         new hClientSrv().getFind(emID, cb => { $scope.clients = cb; $scope.$apply(); }) ;
    };

    new hClientSrv().getFind({}, cb => { $scope.clients = cb;    $scope.$apply();});
    new dcDocsStreamSrv().getAll(     cb => { $scope.documents = cb;  $scope.$apply();});


    $scope.SetDate = (data,dt,index) => {
       if(index !== 0){
         $scope.Dt=$filter('date')(dt, 'dd.MM.yyyy');
         $scope.NewDt=$filter('date')(data[index-1].Changed, 'dd.MM.yyyy');
             if ($scope.Dt == $scope.NewDt)
                 return false;
             else
                 return true;
       }
       else
          return true;

    };

    //trans
    // var trans = () => {
    //   $translate(['selectAll']).then(a => {
    //    $scope.employees.data[0].emName = '- ' + a.selectAll + ' -';

    //   });
    // };

    // $rootScope.$on('$translateChangeSuccess', () => {
    //   trans();
    // });
});
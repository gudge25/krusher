crmUA.controller('FavoritesNewCtrl', function($scope, $filter,$uibModal,$stateParams,i18nService, $translate) {
    $scope.manyAction =  new FavoriteViewModel($scope,$filter,new FavoritesSrv, $translate);

    function FSrv(a,b){
      $scope.favName = a.clName;  $scope.uID = a.uID; $scope.getFavList(); $scope.type = $filter('translate')(b); $scope.$apply();
    }

    if (Boolean($stateParams.clID)) {
      $scope.CurID = $stateParams.clID;
      new crmClientFindSrv().getFind({clID :$scope.CurID},  cb => { FSrv(cb[0],'client'); });
    }
    if (Boolean($stateParams.dcID)) {
      $scope.CurID = $stateParams.dcID;
      new slDealSrv().getFind({dcID:$scope.CurID},     cb => { FSrv(cb[0],'deal'); });
    }
    if (Boolean($stateParams.psID)) {
      $scope.CurID = $stateParams.psID;
      new stProductSrv().getFind({psID:$scope.CurID},  cb => { FSrv(cb[0],'newProduct'); });
    }
});
crmUA.controller('FavoritesPreViewCtrl', function($scope, $filter,$uibModal,$stateParams,i18nService, $translate,$log,NgTableParams,$timeout) {
  $scope.manyAction =  new FavoriteViewModel($scope,$filter,new FavoritesSrv, $translate);
  $scope.tableParams = new NgTableParams();
  $scope.selectAll = false;
  $scope.getFavList();

  $scope.toogleAllCheckBox = a => {
    if ($scope.selectAll === true) {
      for ( var i = 0; i < a.length; i++ ) {
        a[i].select = true;
      }
    } else {
      for ( var i = 0; i < a.length; i++ ) {
        a[i].select = false;
      }
    }
  };

  $scope.delete = row => {
    if (row !== undefined) {
      new FavoritesSrv().del( row.uID, cb => $scope.getFavList());
    } else {
      $scope.Favorites.forEach(item => {
        if ( item.select ===true )  new FavoritesSrv().del( item.uID);
      });
      $scope.getFavList();
      $timeout( () => {$scope.selectAll = false;}, 0);
    }
  };

  $scope.gridOptions = {
    enableFiltering: true,
    paginationPageSizes: [25, 50, 75],
    paginationPageSize: 25,
    enableRowSelection: true,
    enableSelectAll: true,
    columnDefs: [
    { name:'select',
    field:'',
    cellTemplate: '<div><input tabindex="-1" type="checkbox" ng-model="row.entity.select" ng-click="con(row.entity.select)" style="margin:30% 0 0 30%;"/></div>',
    headerCellTemplate: '<div><input tabindex="-1" type="checkbox" ng-model="grid.appScope.selectAll" style="margin:30% 0 0 30%;"' +
    'ng-click="grid.appScope.toogleAllCheckBox(grid.appScope.gridOptions.data)" /></div>',
    width: '2%'},
    { name: $filter('translate')('type'),width:'18%', field: 'faModel', cellTemplate: '<div class="ui-grid-cell-contents" ><button class="btn-link" ng-click="grid.appScope.manyAction.goToDoc(row.entity.faID, row.entity.faModel)">{{COL_FIELD}}</button></div>' },
    { name: $filter('translate')('inform'), width:'35%', field: 'faInfo'},
    { name: $filter('translate')('Comment'), width:'35%', field:'faComment'},
    { name:'Del', field:'', width:'10%', cellTemplate:'<div><button class="btn btn-default" style="margin-left:30%" ng-click="grid.appScope.delete(row.entity)">'+$filter('translate')('del')+'</button></div>', headerCellTemplate: '<div></div>'},
    ],
  };
  i18nService.setCurrentLang('ru');
});
crmUA.controller('SearchDocumentsCtrl', function($scope,$filter,$http,$timeout,i18nService,$translate,$rootScope) {

	$scope.model = new dcDocsSearchModel('').put();
	$scope.manyAction =  new dcDocsSearchViewModel($scope, $filter); //TODO сделать глобальньій ViewModel
  
  $scope.manyAction.Find();
  
  // $scope.gridOptions = {
  //   enableFiltering: true,
  //   enableRowHashing:false,
  //   paginationPageSizes: [25, 50, 75],
  //   paginationPageSize: 25,
  //   enableColumnResizing: true,
  //   columnDefs: [
  //     { name:$filter('translate')('type') ,width:100, field: 'dcType',cellTemplate: '<div class="ui-grid-cell-contents" uib-tooltip="Ид документа: {{row.entity.dcID}}"><button class="btn-link" ng-click="grid.appScope.manyAction.goToDoc(row.entity.dcID)">{{COL_FIELD}}</button></div>'  },
  //     { name:'№ '+$filter('translate')('document')      , width:130, field: 'dcNo'},
  //     { name:$filter('translate')('date')               , field:'dcDate',width:100, cellFilter:'date:\'dd.MM.yyyy\'' },
  //     { name:$filter('translate')('status')             , field: 'dcStatusName',width:150},
  //     { name:$filter('translate')('client')             , field: 'clName',width:300,cellTemplate: '<div class="ui-grid-cell-contents" ><a ng-href="/#!/clientPreView/{{row.entity.clID}}">{{COL_FIELD}}</a></div>' },
  //     { name:$filter('translate')('amount')             , field: 'dcSum',width:100 },
  //     { name:$filter('translate')('responsible')        , field: 'emName',width:150,cellTemplate:'<div class="ui-grid-cell-contents" ><a ng-href="/#!/edit/employee/{{row.entity.emID}}">{{COL_FIELD}}</a></div>' },
  //     { name:$filter('translate')('createdDate')        , field: 'Created',width:150,cellFilter: 'date:\'dd.MM.yyyy HH:mm:ss\'' },
  //     { name:$filter('translate')('editDate')           , field: 'Changed',width:150, cellFilter:'date:\'dd.MM.yyyy HH:mm:ss\''},
  //     { name:$filter('translate')('cratedBy')           , field: 'CreatedName',width:200,cellTemplate: '<div class="ui-grid-cell-contents"><a ng-href="/#!/edit/employee/{{row.entity.CreatedBy}}">{{COL_FIELD}}</a></div>' },
  //     { name:$filter('translate')('whoEdit')            , field: 'EditedName',width:200,cellTemplate: '<div class="ui-grid-cell-contents"><a ng-href="/#!/edit/employee/{{row.entity.ChangedBy}}">{{COL_FIELD}}</a></div>' },
  //     { name:$filter('translate')('Comment')            , width:200, field: 'dcComment'},
  //     { name:$filter('translate')('foundationDocument') , field: 'dcLink',width:180 }
  //   ],
  // };
  // i18nService.setCurrentLang(lang);
});
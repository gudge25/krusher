crmUA.controller('SearchClientsCtrl', function($scope,$filter,$http,i18nService,$translate) {

  $scope.newClient  = new crmClientSearch2Model('').post();
  $scope.manyAction = new crmClientStreamViewModel($scope, $filter);

  $scope.clientsResult;
  $scope.enumsResult = $scope.EnumsGroup[5];

  var lang = $translate.use();

  //$scope.tableParams = new NgTableParams();

  filterEmp = (input,empArr) => {
    //only for responsibles
    if( Array.isArray(input) ){
      let temp = [];
      for (var i = 0; i < input.length; i++) {
        for (var j = 0; j < empArr.length; j++) {
          if(empArr[j].emID === input[i]){
            temp.push({emName: empArr[j].emName, emID: empArr[j].emID});
          }
        }
      }
      return temp;
    }
        {
          for (var i = 0; i < empArr.length; i++) {
            if(empArr[i].emID === input){
              return empArr[i].emName;
            }
          }

        }
  };

  $scope.searchClient = model => {
    clearTimeout($scope.debounceWS);
    $scope.debounceWS = setTimeout(() => {
        let tempClient = new crmClientSearch2Model(model).post();

        for (let i in tempClient) {
          if(tempClient[i] === undefined|| tempClient[i] === null||tempClient[i] === "") {
            delete tempClient[i];
          }
        }

        new crmClientSearch2Srv().ins(tempClient,cb   => {
                $scope.tableParams.settings({
                  dataset: cb
                });

                $scope.gridOptions.data = cb;
                //new emEmployeeSrv().getFind({}, cb => {$scope.Employees = cb;
                for (var i = 0; i < $scope.gridOptions.data.length; i++) {
                  let c  = filterEmp($scope.gridOptions.data[i].CreatedBy,$scope.employees.data);
                  let e  = filterEmp($scope.gridOptions.data[i].ChangedBy,$scope.employees.data);
                  if($scope.gridOptions.data[i].Responsibles != null){
                  let responsibles = filterEmp($scope.gridOptions.data[i].Responsibles,$scope.employees.data);
                  Object.defineProperty($scope.gridOptions.data[i],'ResponsiblesNames',{value:responsibles} );
                }
                  Object.defineProperty($scope.gridOptions.data[i],'CreatedName',{value:c} );
                  Object.defineProperty($scope.gridOptions.data[i],'EditedName',{value:e} );
                }
              //});
                $scope.$apply();
        });
    }, 1000);
  };

  $scope.searchClient({});

  $scope.gridOptions = {
    enableFiltering: true,
    paginationPageSizes: [25, 50, 75],
    paginationPageSize: 25,
    columnDefs: [
      { name: $filter('translate')('client')      ,width:400, field: 'clName', cellTemplate: '<div class="ui-grid-cell-contents" ><i class="fa fa-user" ng-show="row.entity.IsPerson" uib-tooltip="{{row.entity.IsPerson | Person}}"></i><i class="fa fa-building" ng-hide="row.entity.IsPerson" uib-tooltip="{{row.entity.IsPerson | Person}}"></i> <a ng-href="/#!/clientPreView/{{row.entity.clID}}">{{COL_FIELD}}</a></div>' },
      { name: $filter('translate')('contacts')    ,field:'Contacts',width:150, cellTemplate: '<div class="ngCellText" ng-repeat="item in row.entity[col.field]">{{item}}</div>'},
      { name: $filter('translate')('cratedBy')    ,field: 'CreatedBy',width:150,cellTemplate: '<div class="ui-grid-cell-contents" ><a ng-href="/#!/edit/employee/{{COL_FIELD}}">{{row.entity.CreatedName}}</a> </div>' },
      { name: $filter('translate')('whoEdit')     ,field: 'ChangedBy',width:150,cellTemplate: '<div class="ui-grid-cell-contents" ><a ng-href="/#!/edit/employee/{{COL_FIELD}}">{{row.entity.EditedName}}</a> </div>' },
      { name: $filter('translate')('createdDate') ,field: 'Created',width:150,cellFilter: 'date:\'dd.MM.yyyy HH:mm:ss\'' },
      { name: $filter('translate')('editDate')    ,field: 'Changed',width:150,cellFilter: 'date:\'dd.MM.yyyy HH:mm:ss\'' },
      { name: $filter('translate')('active')      ,field: 'IsActive',width:100,cellTemplate: '<div class="ui-grid-cell-contents" ><input type="checkbox" ng-checked="COL_FIELD" disabled /></div>' },
      { name: $filter('translate')('responsible') ,field: 'Responsibles',width:200,cellTemplate: '<div class="ui-grid-cell-contents" ><div ng-repeat="r in row.entity.ResponsiblesNames"><span><a ng-href="/#!/edit/employee/{{r.emID}}">{{r.emName}}</a></span></div></div>' },
      { name: $filter('translate')('Comment')     ,width:150, field: 'Comment'}
    ]
  };

 i18nService.setCurrentLang(lang);
});
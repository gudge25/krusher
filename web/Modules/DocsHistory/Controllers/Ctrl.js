crmUA.controller('DocsHistoryCtrl', function($scope, $filter, $stateParams, NgTableParams ) {
    new dcDocsHistorySrv().get($stateParams.dcID , cb => $scope.DocsHistory = cb );
    $scope.tableParams = new NgTableParams();
});
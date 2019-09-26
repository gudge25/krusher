crmUA.controller('RecordsExportNew', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new RecordsExportViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new ccRecordsModel('').put();
});
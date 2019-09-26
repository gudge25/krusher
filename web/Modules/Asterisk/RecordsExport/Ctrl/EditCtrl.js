crmUA.controller('RecordsExportEditCtrl', function($scope, $filter, $translate, $stateParams, ModalItems, $rootScope) {
    $scope.manyAction =  new RecordsExportViewModel($scope,$filter,$translate,$rootScope);
    // var cbID = $stateParams.cbID;
    // $scope.modelItems = { cbID , limit : 15 };

    console.log(ModalItems);
    console.log($stateParams);
    if(ModalItems) $scope.upd = ModalItems;
    // new ccRecordsSrv().getFind({cbID}, cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });

    $scope.f = [
        { "type" : "ANSWERED"   , "disposition" : $filter('translate')('answered'),         "color" : "badge-success" , tvID: 7001 },
        { "type" : "FAILED"     , "disposition" : $filter('translate')('error'),            "color" : "badge-danger"  , tvID: 7004 },
        { "type" : "BUSY"       , "disposition" : $filter('translate')('busy'),             "color" : "badge-warning" , tvID: 7003 },
        { "type" : "CONGESTION" , "disposition" : $filter('translate')('noavailable'),      "color" : "badge-info"    , tvID: 7005 },
        { "type" : "NO ANSWER"  , "disposition" : $filter('translate')('didNotAnswer'),     "color" : "badge-default" , tvID: 7002 },
        { "type" : "UP"         , "disposition" : $filter('translate')('Up'),               "color" : "badge-default" , tvID: 7006 },
        { "type" : "Ringing"    , "disposition" : $filter('translate')('Ringing'),          "color" : "badge-default" , tvID: 7007 },
        { "type" : "LIMIT"      , "disposition" : $filter('translate')('LIMIT'),            "color" : "badge-default" , tvID: 7008 },
        { "type" : "BLOCKED"    , "disposition" : $filter('translate')('BLOCKED'),          "color" : "badge-default" , tvID: 7009 },
        { "type" : "CANCEL"    ,  "disposition" : $filter('translate')('CANCEL'),           "color" : "badge-default" , tvID: 7010 }
    ];
    $scope.callType = [{ Name: $filter('translate')('missed'), NameT:'isMissed'}, { Name: $filter('translate')('unique') , NameT: 'isUnique'}];
});
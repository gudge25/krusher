class ccContactViewModel extends BaseViewModel {
    constructor($scope,$timeout,$stateParams,$filter,$translate,$rootScope, ngAudio, AclService)
    {
        super($scope,$filter,new ccContactSrv(), $translate, AclService);
        $scope.Export = a => {
            new ccExportSrv().download($scope.model);
        };

        $scope.RecordsExport = () => {
            new ccRecordsSrv().ins($scope.model, cb => {  window.location = "/#!/RecordsExport"; console.log($scope.model); });
        };

    }
}
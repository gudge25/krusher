class RecordsExportViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter, new ccRecordsSrv(), $translate);
    }
}
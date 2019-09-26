class CallsReportViewMode extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new emEmployeeCallsSrv());
    }
}
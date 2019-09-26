class QReportViewMode extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new fmQuestionReportSrv);
    }
}
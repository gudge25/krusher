class fmQuestionItemsReportSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.QuestionItemsReport, fmQuestionItemsReportModel, 'qID');
    }
}
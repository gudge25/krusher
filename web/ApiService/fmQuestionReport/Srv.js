class fmQuestionReportSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.QuestionReport, fmQuestionReportModel, 'tpID');
    }
}
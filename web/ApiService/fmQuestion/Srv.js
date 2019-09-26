class fmQuestionSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.Questions, fmQuestionsModel, 'qID');
    }
}
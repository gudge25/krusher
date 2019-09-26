class fmQuestionItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.QuestionItems, fmQuestionItemsModel, 'qiID');
    }
}
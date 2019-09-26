class usCommentsSrv extends BaseSrv {
    constructor()
    {
        super(API.us.Comment, usCommentsModel, 'uID');
    }
}
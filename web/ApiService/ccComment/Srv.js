class ccCommentSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.Comment, ccCommentModel, 'comID');
    }
}
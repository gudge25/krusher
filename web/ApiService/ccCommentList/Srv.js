class ccCommentListSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.CommentList, ccCommentListModel, 'comID');
    }
}
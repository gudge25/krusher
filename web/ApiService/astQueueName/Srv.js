class astQueueMemberSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.QueueMember, astQueueMemberModel, 'quemID');
    }
}
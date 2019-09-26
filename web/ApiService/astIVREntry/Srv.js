class astIVREntrySrv extends BaseSrv {
    constructor()
    {
        super(API.ast.IVREntry, astIVRItemsModel, 'entry_id');
    }
}
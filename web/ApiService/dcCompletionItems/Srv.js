class CompletionItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.CompletionItems, CompletionItemsModel, 'iiID');
    }
}
class fmFormItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.FormItems, fmFormsItemsModel, 'dcID');
    }
}
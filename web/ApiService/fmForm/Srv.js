class fmFormsSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.Forms, fmFormsModel, 'dcID');
    }
}
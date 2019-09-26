class fmFormTypesSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.FormTypes, fmFormTypesModel, 'tpID');
    }
}
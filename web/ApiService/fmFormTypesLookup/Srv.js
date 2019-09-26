class fmFormTypeLookupSrv extends BaseSrv {
    constructor()
    {
        super(API.fm.FormTypesLookup, fmFormTypeLookupModel, 'tpID');
    }
}
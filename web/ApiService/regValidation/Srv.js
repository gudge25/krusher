class regValidationSrv extends BaseSrv {
    constructor()
    {
        super(API.reg.Validation, regValidationModel, 'regID');
    }
}
class smsSingleSrv extends BaseSrv {
    constructor()
    {
        super(API.sms.Single, smsSingleModel, 'dcID');
    }
}
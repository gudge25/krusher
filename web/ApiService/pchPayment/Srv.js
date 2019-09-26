class pchPaymentSrv extends BaseSrv {
    constructor()
    {
        super(API.pch.Payment, pchPaymentModel, 'dcID');
    }
}
class ccContactSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.Contact, ccContactModel, 'dcID');
    }
}
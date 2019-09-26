class regAreaSrv extends BaseSrv {
    constructor()
    {
        super(API.reg.Areas, regAreaModel, 'aID');
    }
}
class emPasswordSrv extends BaseSrv {
    constructor()
    {
        super(API.em.Password, emPasswordModel, 'emID');
    }
}
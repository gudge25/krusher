class regOperatorSrv extends BaseSrv {
    constructor()
    {
        super(API.reg.operators, regOperatorModel, 'oID');
    }
}
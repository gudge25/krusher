class astSippeersSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Sippeers, astSippeersModel, 'sipID');
    }
}
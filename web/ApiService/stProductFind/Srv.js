class stProductFindSrv extends BaseSrv {
    constructor()
    {
        super(API.st.Products, stProductFindModel, 'psID');
    }
}
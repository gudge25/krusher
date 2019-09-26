class stProductSrv extends BaseSrv {
    constructor()
    {
        super(API.st.Products, stProductModel, 'psID');
    }
}
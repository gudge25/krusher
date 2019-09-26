class usMeasuresSrv extends BaseSrv {
    constructor()
    {
        super(API.us.Measures, usMeasuresModel, 'msID');
    }
}
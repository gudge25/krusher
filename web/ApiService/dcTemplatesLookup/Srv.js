class dcTemplatesLookupSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.TemplatesLookup, dcTemplatesLookupModel, 'dcTypeID');
    }
}
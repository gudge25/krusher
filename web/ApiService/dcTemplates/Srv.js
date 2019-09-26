class dcTemplatesSrv extends BaseSrv {
    constructor()
    {
        super(API.dc.Templates, dcTemplatesModel, 'dtID');
    }
}
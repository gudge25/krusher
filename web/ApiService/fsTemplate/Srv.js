class fsTemplatesSrv extends BaseSrv {
    constructor()
    {
        super(API.fs.Templates, fsTemplatesModel, 'ftID');
    }
}
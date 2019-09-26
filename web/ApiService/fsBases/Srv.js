class fsBasesSrv extends BaseSrv {
    constructor()
    {
        super( API.fs.Bases, fsBasesModel, 'dbID');
    }
}
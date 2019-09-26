class fsBasesLookupSrv extends BaseSrv {
    constructor()
    {
        super( API.fs.BasesLookup, fsBasesLookupModel, 'dbID');
    }
}
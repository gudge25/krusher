class fsFileClaerSrv extends BaseSrv {
    constructor()
    {
        super( API.fs.FilesClear, fsFileClearModel, 'ffID');
    }

}

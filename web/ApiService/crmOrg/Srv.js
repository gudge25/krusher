class orgSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.org, orgModel, 'clID');
    }
}
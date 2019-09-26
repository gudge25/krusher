class crmClientParentSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Parent, crmClientParentModel, 'ParentID');
    }
}
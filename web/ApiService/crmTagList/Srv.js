class crmTagListSrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.TagList, crmTagListModel, 'tagID');
    }
}
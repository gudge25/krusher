class crmClientSummarySrv extends BaseSrv {
    constructor()
    {
        super(API.crm.Client.Summary, crmClientSummaryModel, 'clName');
    }
}
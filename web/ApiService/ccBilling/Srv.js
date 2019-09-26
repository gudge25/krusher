class ccBillingSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.Billing, ccBillingModel, '');
    }

	fileDownload(id){
        $.fileDownload(API.cc.Billing + '/' +  new Date(id).toString("yyyy-MM-dd"));
    }
}
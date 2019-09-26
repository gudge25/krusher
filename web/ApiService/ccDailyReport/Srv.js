class ccDailyReportSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.DailyReport, ccDailyReportModel, '');
    }

	fileDownload(id){
        $.fileDownload(API.cc.DailyReport + '/' + new Date(id).toString("yyyy-MM-dd"));
    }
}
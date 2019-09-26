class cccDailyReportCallsSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.DailyCalls, ccDailyReportCallsModel, '');
    }

	fileDownload(id){
        $.fileDownload(API.cc.DailyCalls + '/' + new Date(id).toString("yyyy-MM-dd"));
    }
}
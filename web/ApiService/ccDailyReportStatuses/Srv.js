class ccDailyReportStatusesSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.DailyStatuses, ccDailyReportStatusesModel, '');
    }

	fileDownload(id){
        $.fileDownload(API.cc.DailyStatuses + '/' + new Date(id).toString("yyyy-MM-dd"));
    }
}
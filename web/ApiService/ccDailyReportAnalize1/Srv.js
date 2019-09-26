class ccAnalize1ReportSrv extends BaseSrv {
    constructor()
    {
        super(API.cc.Analize1, ccAnalize1ReportModel, '');
    }

	fileDownload(id){
        $.fileDownload(API.cc.DailyReport + '/' + new Date(id).toString("yyyy-MM-dd"));
    }
}
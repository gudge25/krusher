class ccDailyReportExportModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    postFind(){
        //super.postFind();
        let  p = this.p; delete this.p; delete this.isActive;
        this.DateFrom   = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo     = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null; // new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs      = p.emIDs !== undefined                        ? p.emIDs.map( x =>  x.emID )                               : [] ;
        
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.clIDs          = p.clIDs                                       ? p.clIDs.map( x =>  parseInt(x.clID) )                     : [] ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels.map( x =>  x.trName)                           : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs.map( x =>  x.ffID )                               : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes.map( x =>  x.tvID )                           : [] ;
        this.ManagerIDs     = p.ManagerIDs !== undefined                    ? p.ManagerIDs.map( x =>  x.emID )                           : [] ;
        this.coIDs          = p.coIDs !== undefined                         ? p.coIDs.map( x =>  x.coID )                               : [] ;
        this.clIDs          = p.clIDs !== undefined                         ? p.clIDs.map( x =>  x.coID )                               : [] ;

        return this;
    }
}
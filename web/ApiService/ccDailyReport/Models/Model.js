class ccDailyReportModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.Period                     = p.Period                      ? p.Period.toString()                       : null;
        this.hourPeriod                 = p.hourPeriod                  ? p.hourPeriod.toString()                   : null;
        this.CallsCount                 = p.CallsCount                  ? parseInt(p.CallsCount)                    : null;
        this.ReceivedBefore20sec        = p.ReceivedBefore20sec         ? parseInt(p.ReceivedBefore20sec)           : null;
        this.ReceivedBefore20secPercent = p.ReceivedBefore20secPercent  ? parseInt(p.ReceivedBefore20secPercent)    : null;
        this.ReceivedBefore30sec        = p.ReceivedBefore30sec         ? parseInt(p.ReceivedBefore30sec)           : null;
        this.ReceivedBefore30secPercent = p.ReceivedBefore30secPercent  ? parseInt(p.ReceivedBefore30secPercent)    : null;
        this.ReceivedBefore60sec        = p.ReceivedBefore60sec         ? parseInt(p.ReceivedBefore60sec)           : null;
        this.ReceivedBefore60secPercent = p.ReceivedBefore60secPercent  ? parseInt(p.ReceivedBefore60secPercent)    : null;
        this.ReceivedAfter60sec         = p.ReceivedAfter60sec          ? parseInt(p.ReceivedAfter60sec)            : null;
        this.ReceivedAfter60secPercent  = p.ReceivedAfter60secPercent   ? parseInt(p.ReceivedAfter60secPercent)     : null;
        this.ReceivedCalls              = p.ReceivedCalls               ? parseInt(p.ReceivedCalls)                 : null;
        this.LostBefore20sec            = p.LostBefore20sec             ? parseInt(p.LostBefore20sec)               : null;
        this.LostBefore20secPercent     = p.LostBefore20secPercent      ? parseInt(p.LostBefore20secPercent)        : null;
        this.LostBefore30sec            = p.LostBefore30sec             ? parseInt(p.LostBefore30sec)               : null;
        this.LostBefore30secPercent     = p.LostBefore30secPercent      ? parseInt(p.LostBefore30secPercent)        : null;
        this.LostBefore60sec            = p.LostBefore60sec             ? parseInt(p.LostBefore60sec)               : null;
        this.LostBefore60secPercent     = p.LostBefore60secPercent      ? parseInt(p.LostBefore60secPercent)        : null;
        this.LostAfter60sec             = p.LostAfter60sec              ? parseInt(p.LostAfter60sec)                : null;
        this.LostAfter60secPercent      = p.LostAfter60secPercent       ? parseInt(p.LostAfter60secPercent)         : null;
        this.LostCalls                  = p.LostCalls                   ? parseInt(p.LostCalls)                     : null;
        this.AHT                        = p.AHT                         ? p.AHT                                     : null;
        this.SL                         = p.SL                          ? parseInt(p.SL)                            : null;
        this.LCR                        = p.LCR                         ? p.LCR                                     : null;
        this.ATT                        = p.ATT                         ? p.ATT                                     : null;
        this.LCR                        = p.LCR                         ? p.LCR                                     : null;
        this.ATT                        = p.ATT                         ? p.ATT                                     : null;
        return this;
    }
 
    post(){
        let p = this.p; 
        super.postFind(p); delete this.p; delete this.isActive; delete this.offset; delete this.limit; delete this.sorting; delete this.field;   
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs          = p.emIDs !== undefined     ? p.emIDs.map( x =>  x.emID )                           : [];
        
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.clIDs          = p.clIDs                                       ? p.clIDs.map( x =>  parseInt(x.clID) )                     : [] ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels.map( x =>  x.trName)                           : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs.map( x =>  x.ffID )                               : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes.map( x =>  x.tvID )                           : [] ;
        this.ManagerIDs     = p.ManagerIDs !== undefined                    ? p.ManagerIDs.map( x =>  x.emID )                          : [] ;
        this.coIDs          = p.coIDs !== undefined                         ? p.coIDs.map( x =>  x.coID )                               : [] ;
        //this.targets        = p.targets !== undefined                       ? p.targets                                  : [] ;

        return this;
    }

    postFindNotMap(){
        let p = this.p; delete this.p; delete this.isActive;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs                           : [];                             
        
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels                                                : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs                                                   : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes                                               : [] ;
        this.ManagerIDs     = p.ManagerIDs !== undefined                    ? p.ManagerIDs                                              : [] ;
        this.coIDs          = p.coIDs                                       ? p.coIDs                                                   : [] ;
        this.dcIDs          = p.dcIDs                                       ? p.dcIDs                                                   : [] ;
        this.ContactStatuses    = p.ContactStatuses                         ? p.ContactStatuses                                         : [] ; 
        this.targets        = p.targets                                     ? p.targets                                                 : [] ;

        return this;
    }

}
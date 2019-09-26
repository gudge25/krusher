class ccDailyReportCallsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.Comment                    = p.Comment                     ? p.Comment.toString()                  : null;
        this.ContactStatus              = p.ContactStatus               ? p.ContactStatus.toString()  : null;
        this.ContactStatusName          = p.ContactStatusName           ? p.ContactStatusName.toString()        : null;
        this.adsName                    = p.adsName                     ? p.adsName.toString()                  : null;
        //this.billsec                    = p.billsec                     ? parseInt(p.billsec)                   : null;
        this.ccName                     = p.ccName                      ? p.ccName.toString()                   : null;
        this.duration                   = p.duration                    ? parseInt(p.duration)                  : null;
        this.emID                       = p.emID                        ? parseInt(p.emID)                      : null;
        this.emName                     = p.emName                      ? p.emName.toString()                   : null;
        //this.serviceLevel               = p.serviceLevel                ? parseInt(p.serviceLevel)              : null;
        this.duration                   = p.duration                    ? (new Date()).clearTime().addSeconds(parseInt(p.duration)).toString('hh:mm:ss')        : null;
        this.billsec                    = p.billsec                     ? (new Date()).clearTime().addSeconds(parseInt(p.billsec)).toString('hh:mm:ss')         : null;
        this.serviceLevel               = p.serviceLevel                ? (new Date()).clearTime().addSeconds(parseInt(p.serviceLevel)).toString('hh:mm:ss')    : null;
        return this;
    }
 
    post(){
        let p = this.p; 
        super.postFind(); delete this.p;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null; // new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs.map( x =>  x.emID )                               : [] ;
        this.dcStatuss      = p.dcStatuss                                   ? p.dcStatuss.map( x =>  x.tvID )                           : [] ;
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.billsec        = p.billsec                                     ? p.billsec                                                 : null ;
        this.comparison     = p.comparison                                  ? p.comparison                                              : "=" ;
        this.clIDs          = p.clIDs                                       ? p.clIDs.map( x =>  parseInt(x.clID) )                     : [] ;
        this.ccNames        = p.ccNames                                     ? p.ccNames.map( x => x.trim() )                            : [] ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels.map( x =>  x.trName)                           : [] ;
        this.id_scenarios   = p.id_scenarios                                ? p.id_scenarios.map( x =>  x.id_scenario )                 : [] ;
        this.id_autodials   = p.id_autodials                                ? p.id_autodials.map( x =>  x.id_autodial )                 : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs.map( x =>  x.ffID )                               : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes.map( x =>  x.tvID )                           : [] ;
        this.ManageIDs      = p.ManageIDs !== undefined                     ? p.ManageIDs.map( x =>  x.emID )                           : [] ;
        this.coIDs          = p.coIDs !== undefined                         ? p.coIDs.map( x =>  x.coID )                               : [] ;
        this.dcIDs          = p.dcIDs !== undefined                         ? p.dcIDs.map( x =>  x.dcID )                               : [] ;
        this.isMissed       = isBoolean(p.isMissed)     ? Boolean(p.isMissed)   : false ;
        this.isUnique       = isBoolean(p.isUnique)     ? Boolean(p.isUnique)   : false ;
        this.limit          = p.limit                   ? p.limit               : 100 ;
        //this.targets        = p.targets !== undefined                       ? p.targets                                  : [] ;
        
        return this;
    }

    postFindNotMap(){
        //super.postFind();
        let p = this.p; delete this.p;  
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs                                                   : [] ;
        this.dcStatuss      = p.dcStatuss                                   ? p.dcStatuss                                               : [] ;
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.billsec        = p.billsec                                     ? p.billsec                                                 : null ;
        this.comparison     = p.comparison                                  ? p.comparison                                              : "=" ;
        this.clIDs          = p.clIDs                                       ? p.clIDs                                                   : [] ;
        this.ccNames        = p.ccNames                                     ? p.ccNames                                                 : [] ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels                                                : [] ;
        this.id_scenarios   = p.id_scenarios                                ? p.id_scenarios                                            : [] ;
        this.id_autodials   = p.id_autodials                                ? p.id_autodials                                            : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs                                                   : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes                                               : [] ;
        this.ManageIDs      = p.ManageIDs !== undefined                     ? p.ManageIDs                                               : [] ;
        this.coIDs          = p.coIDs                                       ? p.coIDs                                                   : [] ;
        this.dcIDs          = p.dcIDs                                       ? p.dcIDs                                                   : [] ;
        this.isMissed       = isBoolean(p.isMissed)     ? Boolean(p.isMissed)   : false ;
        this.isUnique       = isBoolean(p.isUnique)     ? Boolean(p.isUnique)   : false ;
        this.limit          = p.limit                   ? p.limit               : 100 ;
        this.target         = p.target                  ? p.target              : null ;
        this.targets        = p.targets                                     ? p.targets                                                 : [] ;

        return this;
    }
}
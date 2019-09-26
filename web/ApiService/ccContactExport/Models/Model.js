class ccExportModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    postFind(){
        //super.postFind();
        let  p = this.p;
        let a = new Date().setDate(new Date().getDate()-1);
        delete this.isActive;
        this.isMissed   = isBoolean(p.isMissed)                         ? Boolean(p.isMissed)                                       : false ;
        this.isUnique   = isBoolean(p.isUnique)                         ? Boolean(p.isUnique)                                       : false ;
        this.DateFrom   = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo     = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null; // new Date().toString("yyyy-MM-ddT23:59:59");
        // this.DateFrom   = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")      : new Date(a).toString("yyyy-MM-ddT00:00:00");
        // this.DateTo     = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")        : new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs      = p.emIDs !== undefined                         ? p.emIDs.map( x =>  x.emID )                               : [] ;
        this.dcStatuss  = p.dcStatuss                                   ? p.dcStatuss.map( x =>  x.tvID )                           : [] ;
        //this.Queues     = (p.Queues && p.Queues.indexOf("-") == -1)     ? p.Queues.map( x =>  x.queID )                             : [] ;
        this.IsOut      = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.billsec    = p.billsec                                     ? p.billsec                                                 : null ;
        this.comparison = p.comparison                                  ? p.comparison                                              : "=" ;
        this.clIDs      = p.clIDs                                       ? p.clIDs.map( x =>  x.clID )                               : [] ;
        this.ccNames    = p.ccNames                                     ? p.ccNames.map( x => x ) : [] ;
        this.channels   = (p.channels && p.channels.indexOf("-") == -1) ? p.channels.map( x =>  x.id )                              : [] ;
        this.id_scenarios= p.id_scenarios                               ? p.id_scenarios.map( x =>  x.id_scenario )                 : [] ;
        this.id_autodials= p.id_autodials                               ? p.id_autodials.map( x =>  x.id_autodial )                 : [] ;
        this.ffIDs      = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs.map( x =>  x.ffID )                               : [] ;
        this.CallTypes  = p.CallTypes                                   ? p.CallTypes.map( x =>  x.tvID )                           : [] ;
        this.url        = p.url                                         ? p.url.toString()                                          : window.location.origin ;
        delete this.p;
        return this;
    }
}
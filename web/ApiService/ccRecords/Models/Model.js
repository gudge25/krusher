class ccRecordsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.DateFrom           = p.DateFrom            ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo             = p.DateTo              ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null; // new Date().toString("yyyy-MM-ddT23:59:59");
    }
 
    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dcID               = p.dcID                ? p.dcID                            : null ;
        this.idCR               = p.idCR                ? parseInt(p.idCR)                  : null ;
        this.link               = p.link                ? p.link.toString()                 : null ;
        this.statusReady        = p.statusReady         ? p.statusReady.toString()          : null ;

        this.CallTypes          = p.CallTypes           ? p.CallTypes.split(",").map( a => parseInt(a) )            : null ;
        this.ContactStatuses    = p.ContactStatuses     ? p.ContactStatuses                 : null ;
        this.IsOut              = p.IsOut               ? p.IsOut.toString()                : null ;
        this.ManageIDs          = p.ManageIDs           ? p.ManageIDs.split(",").map( a => parseInt(a) )            : null ;
        this.billsec            = p.billsec             ? p.billsec.toString()              : null ;
        this.ccNames            = p.ccNames             ? p.ccNames.split(",").map( a => parseInt(a) )              : null ;
        this.channels           = p.channels            ? p.channels.split(",").map( a => parseInt(a) )             : null ;
        this.clIDs              = p.clIDs               ? p.clIDs.split(",").map( a => parseInt(a) )                : null ;
        this.coIDs              = p.coIDs               ? p.coIDs.split(",").map( a => parseInt(a) )                : null ;
        this.comparison         = p.comparison          ? p.comparison.toString()           : null ;
        this.dcIDs              = p.dcIDs               ? p.dcIDs.split(",").map( a => parseInt(a) )                : null ;
        this.dcStatuss          = p.dcStatuss           ? p.dcStatuss.split(",").map( a => parseInt(a) )            : null ;
        this.destdata           = p.destdata            ? p.destdata.toString()             : null ;
        this.destdata2          = p.destdata2           ? p.destdata2.toString()            : null ;
        this.destination        = p.destination         ? p.destination.toString()          : null ;
        this.emIDs              = p.emIDs               ? p.emIDs.split(",").map( a => parseInt(a) )                : null ;
        this.ffIDs              = p.ffIDs               ? p.ffIDs.split(",").map( a => parseInt(a) )                : null ;
        this.isActive           = p.isActive            ? p.isActive.toString()             : null ;
        this.isMissed           = p.isMissed            ? p.isMissed.toString()             : null ;
        this.isUnique           = p.isUnique            ? p.isUnique.toString()             : null ;
        this.target             = p.target              ? p.target.toString()               : null ;
        this.convertFormat      = p.convertFormat       ? parseInt(p.convertFormat)                                 : null ;

        return this;
    }
    
    post(){
        super.post();
        let p = this.p; delete this.p; 
        console.log(p.dcStatuss);
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
        this.isMissed       = isBoolean(p.isMissed)                         ? Boolean(p.isMissed)                                       : false ;
        this.isUnique       = isBoolean(p.isUnique)                         ? Boolean(p.isUnique)                                       : false ;
        this.target         = p.target                                      ? p.target                                                  : null ; 
        this.convertFormat  = p.convertFormat                               ? parseInt(p.convertFormat)                                 : 104003 ;

        return this;
    }
    
    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?   new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?   new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.statusReady    = p.statusReady                                 ?   p.statusReady.toString()  : null ;
        return this;
    }
}
class ccDailyReportStatusesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        return  this.p;
    }
 
    post(){
        let p = this.p; 
        super.postFind(p); delete this.p; delete this.isActive; delete this.offset; delete this.limit; delete this.sorting; delete this.field;   
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.clIDs          = p.clIDs                                       ? p.clIDs.map( x =>  parseInt(x.clID) )                     : [] ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels.map( x =>  x.trName)                           : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs.map( x =>  x.ffID )                               : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes.map( x =>  x.tvID )                           : [] ;
        this.ManagerIDs     = p.ManagerIDs !== undefined                    ? p.ManagerIDs.map( x =>  x.emID )                           : [] ;
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
        
        this.IsOut          = isBoolean(p.IsOut)                            ? Boolean(p.IsOut)                                          : null ;
        this.channels       = (p.channels && p.channels.indexOf("-") == -1) ? p.channels                                                : [] ;
        this.ffIDs          = p.ffIDs !== undefined && p.ffIDs !== null     ? p.ffIDs                                                   : [] ;
        this.CallTypes      = p.CallTypes                                   ? p.CallTypes                                               : [] ;
        this.ManagerIDs      = p.ManagerIDs !== undefined                     ? p.ManagerIDs                                               : [] ;
        this.coIDs          = p.coIDs                                       ? p.coIDs                                                   : [] ;
        this.dcIDs          = p.dcIDs                                       ? p.dcIDs                                                   : [] ;
        this.ContactStatuses    = p.ContactStatuses                         ? p.ContactStatuses                                         : [] ; 
        this.targets        = p.targets                                     ? p.targets                                                 : [] ;

        return this;
    }

}

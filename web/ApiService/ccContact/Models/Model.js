class ccContactModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.isMissed       = isBoolean(p.isMissed)     ? Boolean(p.isMissed)   : false ;
        this.isUnique       = isBoolean(p.isUnique)     ? Boolean(p.isUnique)   : false ;
        this.limit          = p.limit                   ? p.limit               : 15 ;
         //this.target         = p.target                  ? p.target              : null ;
        this.target          = isBoolean(p.target)    ? Boolean(p.target)          : p.target ;
    }

    GetModel(){
        let p = this.p;     
        this.emID           = p.emID                ? p.emID                    : null ;
        this.destination    = p.destination         ? parseInt(p.destination)   : null;
        this.destdata       = p.destdata            ? parseInt(p.destdata)      : null;
        this.destdata2      = p.destdata2           ? p.destdata2               : null ;
        this.coID           = p.coID                ? parseInt(p.coID)          : null ;
        this.target         = p.target              ? p.target                  : null ;
        this.CauseCode      = p.CauseCode           ? parseInt(p.CauseCode)     : null ;
        this.CauseDesc      = p.CauseDesc           ? p.CauseDesc.toString()    : null ;
        this.CauseWho       = p.CauseWho            ? parseInt(p.CauseWho)      : null ;
        this.CallType       = p.CallType            ? parseInt(p.CallType)      : null ;
        this.dcID           = p.dcID                ? p.dcID                    : null ;
        this.SIP            = p.SIP                 ? p.SIP.toString()          : null ;
        this.LinkFile       = p.LinkFile            ? p.LinkFile.toString()     : null ;
       
        this.channel        = p.channel             ? p.channel.toString()      : null ;
        this.isAutocall     = p.isAutocall          ? p.isAutocall              : null ;
        this.id_autodial    = p.id_autodial         ? parseInt(p.id_autodial)   : null ;
        this.id_scenario    = p.id_scenario         ? parseInt(p.id_scenario)   : null ;
        this.ffID           = p.ffID !== undefined  ? parseInt(p.ffID)          : null ;
        this.ccName         = p.ccName              ? p.ccName.toString()       : null ;
        this.ContactStatus  = p.ContactStatus       ? parseInt(p.ContactStatus) : null ;
        this.Comment        = p.Comment             ? p.Comment.toString()      : null ;
        this.IsOut          = isBoolean(p.IsOut)    ? Boolean(p.IsOut)          : false ;
        this.ccID           = p.ccID                ? parseInt(p.ccID)          : null ;
        return this;
    }

    get(){
        super.get();
        this.GetModel(); 
        let p = this.p; delete this.p;
        this.dcID           = p.dcID                ? p.dcID                    : null ;

        this.regName        = p.regName;
        this.emName         = p.emName;
        this.ffName         = p.ffName;
        this.duration       = (new Date()).clearTime().addSeconds(p.duration).toString('mm:ss');
        this.billsec        = (new Date()).clearTime().addSeconds(p.billsec).toString('mm:ss');
        this.holdtime       = (new Date()).clearTime().addSeconds(p.holdtime).toString('mm:ss');
        this.serviceLevel   = (new Date()).clearTime().addSeconds(p.serviceLevel).toString('mm:ss');
        this.durationO      = p.duration;
        this.billsecO       = p.billsec;
        this.holdtimeO      = p.holdtime;
        this.serviceLevelO  = p.serviceLevel;
        this.target         = p.target                  ? p.target.split(",")       : null ;
        this.IsPerson       = isBoolean(p.IsPerson)     ? Boolean(p.IsPerson)       : false ;
        this.coName         = p.coName                  ? p.coName                  : null ;
        this.transferFrom   = p.transferFrom            ? p.transferFrom            : null ;
        this.transferTo     = p.transferTo              ? p.transferTo              : null ;
        return this;
    }
    
    put(){
        super.put();
        this.GetModel();
        let p = this.p; delete this.p; delete this.dcLink; delete this.dcComment; delete this.dcSum; delete this.dcStatus; delete this.dcDate; delete this.dcNo; delete this.isMissed; delete this.isUnique; delete this.limit; delete this.HIID;
        this.duration       = p.duration            ? p.durationO           : null;
        this.billsec        = p.billsec             ? p.billsecO            : null;
        this.holdtime       = p.holdtime            ? p.holdtimeO           : null;
        this.disposition    = p.dcStatusName        ? p.dcStatusName        : null;
        this.transferFrom   = p.transferFrom        ? p.transferFrom.join() : [];
        this.transferTo     = p.transferTo          ? p.transferTo.join()   : [];
        this.target         = p.target              ? p.target.join()       : null ;
        return this;
    }
    
    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        delete this.dcLink; delete this.dcComment; delete this.dcSum; delete this.clID; delete this.dcDate; delete this.dcNo; delete this.dcID; delete this.emID; delete this.dcStatus;
        //one day ago
        //let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : new Date().toString("yyyy-MM-ddT00:00:00"); //null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : new Date().toString("yyyy-MM-ddT23:59:59"); //null; // new Date().toString("yyyy-MM-ddT23:59:59");
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
        this.ContactStatuses    = p.ContactStatuses !== undefined           ? p.ContactStatuses.map( x =>  x.tvID )                     : [] ; 
        return this;
    }

    postFindNotMap(){
        super.postFind();
        let p = this.p; delete this.p; delete this.dcLink; delete this.dcComment; delete this.dcSum; delete this.clID; delete this.dcDate; delete this.dcNo; delete this.dcID; delete this.emID; delete this.dcStatus;
        //one day ago
        let a = new Date();//.setDate(new Date().getDate()-1);
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
        this.ContactStatuses    = p.ContactStatuses                         ? p.ContactStatuses                                         : [] ; 
        return this;
    }
}
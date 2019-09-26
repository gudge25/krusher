class emEmployeeCounterModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.Period         = p.Period                  ? p.Period                          : null;
        this.emID           = p.emID                    ? parseInt(p.emID)                  : null;
        this.OutFull        = p.OutFull                 ? parseInt(p.OutFull)               : null;
        this.InFull         = p.InFull                  ? parseInt(p.InFull)                : null;
        this.Full           = p.Full                    ? parseInt(p.Full)                  : null;
        this.OutAnswered    = p.OutAnswered             ? parseInt(p.OutAnswered)           : null;
        this.InAnswered     = p.InAnswered              ? parseInt(p.InAnswered)            : null;
        this.Answered       = p.Answered                ? parseInt(p.Answered)              : null;
        this.OutNoAnswered  = p.OutNoAnswered           ? parseInt(p.OutNoAnswered)         : null;
        this.InNoAnswered   = p.InNoAnswered            ? parseInt(p.InNoAnswered)          : null;
        this.NoAnswered     = p.NoAnswered              ? parseInt(p.NoAnswered)            : null;
        return this;
    }
 
    post(){
        let p = this.p; 
        super.postFind(); delete this.p; delete this.isActive
        this.DateFrom       = p.DateFrom                                    ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null;
        this.DateTo         = p.DateTo                                      ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null;
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs.map( x =>  x.emID )                               : [] ;
        //this.coIDs          = p.coIDs !== undefined                         ? p.coIDs.map( x =>  x.coID )                               : [] ;

        return this;
    }

    postFindNotMap(){
        //super.postFind();
        let p = this.p; delete this.p; delete this.isActive
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs                                                   : [] ;
        //this.coIDs          = p.coIDs !== undefined                         ? p.coIDs                                                   : [] ;

        return this;
    }
}
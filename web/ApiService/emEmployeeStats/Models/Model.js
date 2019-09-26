class emEmployeeStatModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.disposition    = p.disposition         ? p.disposition     : null ;
        this.IsOut          = isBoolean(p.IsOut)    ? Boolean(p.IsOut)  : null ;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;
        this.Period         = p.Period;
        this.QtyCall        = p.QtyCall;
        this.emName         = p.emName;
        this.avgBillMin     = (p.avgBillMin !== "00:00:00" && p.avgBillMin )        ? p.avgBillMin  : null;
        this.avgVoiceMin    = (p.avgVoiceMin !== "00:00:00" && p.avgVoiceMin )      ? p.avgVoiceMin : null;
        this.avgWaitMin     = (p.avgWaitMin !== "00:00:00" && p.avgWaitMin )        ? p.avgWaitMin  : null;
        this.qtyVoiceMin    = (p.qtyVoiceMin !== "00:00:00" && p.qtyVoiceMin )      ? p.qtyVoiceMin : null;
        this.emID           = p.emID        ? p.emID            : null ;
        return this;
    }

    postFind(){
        //super.post();
        var p = this.p; delete this.p;  delete this.isActive;
        //one day ago
        let a = new Date();//.setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.Step           = p.Step        ? p.Step     : null ;
        this.dctID          = p.dctID       ? p.dctID    : null ;
        this.emIDs          = p.emIDs !== undefined     ? p.emIDs.map( x =>  x.emID  !== undefined ?  parseInt(x.emID) : null )   : [] ;

        return this;
    }
}
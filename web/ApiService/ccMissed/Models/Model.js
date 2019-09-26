class ccMissedModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        let p = this.p; delete this.p; delete this.isActive;
        this.missed       = p.missed    ?  p.missed    : null;
        return  this;
    }
 
    post(){
        let p = this.p; delete this.p;   delete this.isActive; 
        //7 day ago
        let a = new Date().setDate(new Date().getDate()-7);
        this.DateFrom       = p.DateFrom            ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.IsOut          = isBoolean(p.IsOut)    ?  Boolean(p.IsOut)     : false;
        this.coIDs          = p.coIDs               ?  p.coIDs              : null;
        this.emIDs          = p.emIDs               ?  p.emIDs              : null;
        this.ManageIDs      = p.ManageIDs           ?  p.ManageIDs          : null;
        return this;
    }
}
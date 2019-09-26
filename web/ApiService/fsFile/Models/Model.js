class fsFileModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ffID       = p.ffID  !== undefined ? parseInt(p.ffID)          : null ;
        this.ffName     = p.ffName              ? p.ffName.toString()       : null ;
        this.dbID       = parseInt(p.dbID)      ? parseInt(p.dbID)          : null ;
        this.Priority   = parseInt(p.Priority)  ? parseInt(p.Priority)      : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.Name       = p.Name;
        this.Qty        = p.Qty;
        this.FilterID   = p.FilterID;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.Priority   = parseInt(p.Priority)  ? parseInt(p.Priority)      : 0 ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ffID       = lookUp(API.us.Sequence, 'ffID').seqValue ;
        this.Priority   = parseInt(p.Priority)  ? parseInt(p.Priority)      : 0 ;
        return this;
    }
}
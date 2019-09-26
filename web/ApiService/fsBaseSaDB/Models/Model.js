class fsBasesSaBDModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dbName     = p.dbName;
        this.ffID       = p.ffID;
        this.ffName     = p.ffName;
        this.FilterID   = p.FilterID;
        this.Qty        = p.Qty;
        this.Name       = p.Name;
        this.clID       = p.clID;
        return this;
    }
}
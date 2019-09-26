class fsDetailModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.cID        = p.cID;
        this.cName      = p.cName;
        this.Count      = p.Count;
        this.isMobile   = p.isMobile;
        this.rgID       = p.rgID;
        this.rgName     = p.rgName;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ffID       = p.ffID !== undefined  ? p.ffID    : null ;
        return this;
    }
}
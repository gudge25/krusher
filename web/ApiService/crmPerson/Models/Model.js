class crmPersonModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.pnID       = p.pnID;
        this.clID       = p.clID    ? p.clID      : null ;
        this.pnName     = p.pnName  ? p.pnName    : null ;
        this.Post       = p.Post    ? p.Post      : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.pnID       = p.pnID    ? p.pnID      : lookUp(API.us.Sequence, 'pnID').seqValue;
        return this;
    }
}
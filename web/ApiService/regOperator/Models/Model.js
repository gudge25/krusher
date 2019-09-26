class regOperatorModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.oID        = p.oID;
        this.oName      = p.oName;
        this.MCC        = p.MCC;
        this.MNC        = p.MNC;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.oID        = p.oID                   ? p.oID                   : lookUp(API.us.Sequence, 'oID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        return this;
    }
}
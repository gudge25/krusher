class regAreaModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.aID        = p.aID;
        this.aName      = p.aName   ? p.aName   : null ;
        this.cID        = p.cID     ? p.cID     : null ;
        this.rgID       = p.rgID    ? p.rgID    : null ;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null ;
        this.langID     = p.langID  ? p.langID  : null ;
     }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.aID       = p.aID    ? p.aID        : lookUp(API.us.Sequence, 'aID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        return this;
    }
}
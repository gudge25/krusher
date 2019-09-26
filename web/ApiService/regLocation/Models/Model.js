class regLocationModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.lID        = p.lID     ? parseInt(p.lID)       : null ;
        this.lName      = p.lName   ? p.lName               : null ;
        this.cID        = p.cID     ? parseInt(p.cID)       : null ;
        this.rgID       = p.rgID    ? parseInt(p.rgID)      : null ;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null ;
        this.langID     = p.langID  ? parseInt(p.langID)    : null ;
     }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.cName      = p.cName   ? p.cName   : null ;
        this.rgName     = p.rgName  ? p.rgName  : null ;
        this.aName      = p.aName   ? p.aName   : null ;

        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.lID       = p.lID    ? parseInt(p.lID)        : lookUp(API.us.Sequence, 'lID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        return this;
    }
}
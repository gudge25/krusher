class stProductModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.psID       = p.psID;
        this.psName     = p.psName  ? p.psName      : null ;
        this.psState    = p.psState ? p.psState     : null ;
        this.psCode     = p.psCode  ? p.psCode      : null ;
        this.msID       = p.msID    ? p.msID        : 0 ;
        this.pctID      = p.pctID   ? p.pctID       : null ;
        this.ParentID   = p.ParentID? p.ParentID    : null ;
        this.bID        = p.bID     ? p.bID         : null ;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)       : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.msName     = p.msName;
        this.pctName    = p.pctName;
        this.pcID       = p.pcID;
        this.uID        = p.uID;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.psID       = p.psID    ? p.psID        : lookUp(API.us.Sequence, 'psID').seqValue;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)       : true ;
        return this;
    }

    postFind(){
        super.post();
        let p = this.p; delete this.p;
        this.psID       = p.psID    ? p.psID        : lookUp(API.us.Sequence, 'psID').seqValue;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)       : true ;
        return this;
    }
}
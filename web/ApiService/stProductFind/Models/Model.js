class stProductFindModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.psName     = p.psName  ? p.psName      : undefined ;
        this.psState    = p.psState ? p.psState     : undefined ;
        this.psCode     = p.psCode  ? p.psCode      : undefined ;
        this.pctID      = p.pctID   ? p.pctID       : undefined ;
        this.bID        = p.bID     ? p.bID         : undefined ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.psID       = p.psID;
        this.msID       = p.msID;
        this.msName     = p.msName;
        this.pctName    = p.pctName;
        this.ParentID   = p.ParentID;
        this.pcID       = p.pcID;
        this.ParentID   = p.ParentID;
        this.isActive   = p.isActive;
        this.bName      = p.bName;
        return this;
    }


     postFind(){
        super.postFind();
        delete this.sorting;
        delete this.field;
        delete this.offset;
        delete this.limit;
        delete this.p;
        return this;
    }
}
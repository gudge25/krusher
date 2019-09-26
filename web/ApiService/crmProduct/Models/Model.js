class crmProductModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID       = p.clID !== undefined  ? p.clID    : null ;
        this.cpID       = p.cpID;
        this.psID       = p.psID                ? p.psID    : null ;
        this.cpQty      = p.cpQty               ? p.cpQty   : null ;
        this.cpPrice    = p.cpPrice             ? p.cpPrice : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.cpID       = p.cpID                ? p.cpID    : lookUp(API.us.Sequence, 'cpID').seqValue;
        return this;
    }
}
class stBrandsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.bID        = p.bID;
        this.bName      = p.bName       ? p.bName       : null ;
        this.isActive   = p.isActive    ? p.isActive    : true ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.bID      = p.bID   ? p.bID             : lookUp(API.us.Sequence, 'bID').seqValue;
        return this;
    }
}
class stCategoriesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.pctID      = p.pctID;
        this.pctName    = p.pctName ? p.pctName     : null ;
        this.ParentID   = p.ParentID? p.ParentID    : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.pctID      = p.pctID   ? p.pctID       : lookUp(API.us.Sequence, 'pctID').seqValue;
        return this;
    }
}
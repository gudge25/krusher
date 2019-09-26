class astTrunkPoolModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.poolID             = p.poolID              ? parseInt(p.poolID)            : null ;
        this.poolName           = p.poolName            ? p.poolName                    : null ;
        this.priority           = p.priority            ? p.priority                    : null ;
        this.coID               = p.coID                ? parseInt(p.coID)              : null;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.poolID               = p.poolID                ? p.poolID                   : lookUp(API.us.Sequence, 'poolID').seqValue;
        return this;
    }
}
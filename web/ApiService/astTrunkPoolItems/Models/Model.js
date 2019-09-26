class astTrunkPoolItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.plID               = p.plID                ? parseInt(p.plID)              : null ;
        this.poolID             = p.poolID              ? parseInt(p.poolID)            : null ;
        this.trID               = p.trID                ? p.trID                        : null ;
        //this.priority           = p.priority            ? p.priority                    : null ;
        this.percent            = p.percent             ? p.percent                     : null ;

    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.percent            = p.percent             ? p.percent                     : 1 ;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.plID               = p.plID                ? p.plID                        : lookUp(API.us.Sequence, 'plID').seqValue;
        this.percent            = p.percent             ? p.percent                     : 1 ;
        return this;
    }
}
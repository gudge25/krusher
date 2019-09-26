class usMeasuresModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.msID       = p.msID;
        this.msName     = p.msName  ? p.msName      : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.msID       = p.msID    ? p.msID        : lookUp(API.us.Sequence, 'msID').seqValue;
        return this;
    }
}
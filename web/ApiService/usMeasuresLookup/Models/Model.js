class usMeasuresLookupModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.msID       = p.msID;
        this.msName     = p.msName;
        return this;
    }
}
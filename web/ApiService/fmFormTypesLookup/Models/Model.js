class fmFormTypeLookupModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.tpID           = p.tpID;
        this.tpName         = p.tpName;
        this.ffName         = p.ffName;
        this.ffID           = p.ffID;
        this.QtyAvg         = p.QtyAvg;
        this.tpHint         = p.tpHint;
        return this;
    }
}
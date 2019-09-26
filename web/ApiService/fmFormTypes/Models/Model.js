class fmFormTypesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.tpID       = p.tpID                    ? parseInt(p.tpID)      : null;
        this.tpName     = p.tpName                  ? p.tpName.toString()   : null;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)   : null;
        this.ffID       = p.ffID                    ? parseInt(p.ffID)      : null;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.tpID       = lookUp(API.us.Sequence, 'tpID').seqValue;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)   : true;
        return this;
    }
}
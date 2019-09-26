class dcTemplatesLookupModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dtID          = p.dtID;
        this.dtName        = p.dtName;
        this.dtTemplate    = p.dtTemplate;
        return this;
    }
}
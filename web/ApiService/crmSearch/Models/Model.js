class crmClientSearchModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID       = p.clID    ;
        this.clName     = p.clName  ;
    }
}
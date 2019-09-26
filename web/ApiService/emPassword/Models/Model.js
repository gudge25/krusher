class emPasswordModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.password       = p.password    ? p.password    : null ;
        this.emID           = p.emID        ? p.emID        : null ;
    }
}
class dcDocsTypesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dctID         = p.dctID;
        this.dctName       = p.dctName;
    }
}
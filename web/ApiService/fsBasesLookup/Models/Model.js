class fsBasesLookupModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
        this.dbID       = p.dbID;
        this.dbName     = p.dbName;
    }
}
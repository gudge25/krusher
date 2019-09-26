class fsFileClearModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ffID       = p.ffID;
    }
}
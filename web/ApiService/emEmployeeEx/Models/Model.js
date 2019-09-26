class emEmployeeExModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.emID       = p.emID        ? p.emID        : EMID;
        this.Settings   = p.Settings    ? p.Settings    : {};
    }
}
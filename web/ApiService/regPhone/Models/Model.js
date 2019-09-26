class regPhoneModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
        this.regID      = p.regID;
        this.regName    = p.regName;
        this.Prefix     = p.Prefix;
        this.ropName    = p.ropName;
        this.rpID       = p.rpID;
        this.raName     = p.raName;
        this.rkSocr     = p.rkSocr;
        this.GMT        = p.GMT;
        this.rcName     = p.rcName;
        this.Phone      = p.Phone;
    }
}
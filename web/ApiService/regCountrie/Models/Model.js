class regCountryModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.cID        = p.cID                     ? parseInt(p.cID)           : null ;
        this.cName      = p.cName                   ? p.cName                   : null ;
        this.langID     = p.langID                  ? parseInt(p.langID)        : null ;
        this.LenNumber1 = p.LenNumber1              ? parseInt(p.LenNumber1)    : null ;
        this.LenNumber2 = p.LenNumber2              ? parseInt(p.LenNumber2)    : null ;
    }
}
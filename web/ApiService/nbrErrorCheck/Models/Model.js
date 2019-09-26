class nbrErrorCheckModel extends BaseModel{
    constructor(p) {
        super(p);
        this.p = p;
        this.adress     = p.adress;
        this.critical   = p.critical;
    }
}
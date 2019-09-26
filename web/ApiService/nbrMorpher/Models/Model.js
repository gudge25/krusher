class nbrMorpherModel extends BaseModel{
    constructor(p) {
        super(p);
        this.p = p;
        this.sex        = p.sex;
        this.famIO      = p.famIO;
        this.fio        = p.fio;
        this.io         = p.io;
    }
}
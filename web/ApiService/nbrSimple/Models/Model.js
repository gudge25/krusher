class nbrSimpleModel extends BaseModel{
    constructor(p) {
        super(p);
        this.p = p;
        this.inn        = p.inn             ? p.inn         : null;
        this.nameFull   = p.nameFull        ? p.nameFull    : null;
        this.nameShort  = p.nameShort       ? p.nameShort   : null;
        this.adress     = p.adress          ? p.adress      : null;
        this.fio        = p.fio             ? p.fio         : null;
        this.io         = p.io              ? p.io          : null;
        this.kvedCode   = p.kvedCode        ? p.kvedCode    : null;
        this.kvedDescr  = p.kvedDescr       ? p.kvedDescr   : null;
        this.phones     = p.phones          ? p.phones      : null;
        this.status     = p.status          ? p.status      : null;
    }
}
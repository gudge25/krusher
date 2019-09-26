class dcDocsStreamModel extends BaseModelDC {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dctName        = p.dctName;
        this.dctID          = p.dctID;
        this.uID            = p.uID         ;
        this.Created        = p.Created;
        this.CreatedBy      = p.CreatedBy;
        this.CreatedName    = p.CreatedName;
        this.dup_action     = p.dup_action;
        this.OLD_clID       = p.OLD_clID;
        this.OLD_dcDate     = p.OLD_dcDate;
        this.OLD_dcNo       = p.OLD_dcNo;
        this.OLD_dcStatus   = p.OLD_dcStatus;
        this.OLD_dcSum      = p.OLD_dcSum;
        this.OLD_emID       = p.OLD_emID;
        return this;
    }

    search(){
        super.post();
    }
}
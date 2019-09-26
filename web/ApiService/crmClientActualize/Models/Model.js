class crmClientActualizeModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    post(){
        super.post();
        var p = this.p; delete this.p;
        this.HIID           = p.HIID;
        this.clID           = p.clID            ? p.clID            : null ;
        return this;
    }
}
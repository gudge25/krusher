class slDealChartModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID        ? p.clID        : 0;
        this.dcStatus       = p.dcStatus    ? p.dcStatus    : null;
        delete this.isActive;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;  delete this.isActive;
        this.psID       = p.psID;
        this.psName     = p.psName;
        this.qty        = p.qty;
        this.Percent    = p.Percent;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;  delete this.isActive;
        return this;
    }
}
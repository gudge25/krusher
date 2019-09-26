class crmClientSummaryModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.clName     = p.clName  ? p.clName  : null ;
        this.ccName     = p.ccName  ? p.ccName  : null ;
        this.ccType     = p.ccType  ? p.ccType  : null ;
        this.regID      = p.regID   ? p.regID   : null ;
        this.offset     = null ;
        this.limit      = null ;
        this.ffID       = p.ffID !== undefined   ? p.ffID    : null ;
        this.clStatus   = p.clStatus? p.clStatus: null ;
        this.ccStatus   = p.ccStatus? p.ccStatus: null ;
        this.emID       = p.emID    ? p.emID    : null ;
        return this;
    }
}
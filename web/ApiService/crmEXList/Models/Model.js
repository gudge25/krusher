class crmClientExListModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID       = p.clID    ? p.clID    : null ;
        this.CallDate   = p.CallDate? p.CallDate: null ;
    }
}
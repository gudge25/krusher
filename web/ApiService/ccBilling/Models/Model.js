class ccBillingModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;
		this.data   = p.data    ? p.data    : new Date(a).toString("yyyy-MM-dd");
        return this;
    }
}

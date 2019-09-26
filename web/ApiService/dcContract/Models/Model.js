class ContractModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.type       = p.type;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.type       = p.type;
        return this;
    }
}
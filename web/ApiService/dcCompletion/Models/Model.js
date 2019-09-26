class CompletionModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.VATSum       = p.VATSum;
        this.Delivery     = p.Delivery;
    }

    get(){
        super.get();
        delete this.p;
        this.dcNo         = 'ОУ-' + this.dcID;
        return this;
    }

    post(){
        super.post();
        delete this.p;
        this.dcNo         = 'ОУ-' + this.dcID;
        return this;
    }
}
class astCallBackModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.cbID                   = p.cbID                ?   parseInt(p.cbID)                    : null;
        this.cbName                 = p.cbName              ?   p.cbName.toString()                 : null;
        this.timeout                = p.timeout             ?   parseInt(p.timeout)                 : null;
        this.isFirstClient          = isBoolean(p.isFirstClient)    ?   Boolean(p.isFirstClient)    : null;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.cbID        = p.cbID         ?   parseInt(p.cbID)     : lookUp(API.us.Sequence, 'cbID').seqValue;
        return this;
    }
}
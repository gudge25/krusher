class astTimeGroupModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.tgID                   = p.tgID                ?   parseInt(p.tgID)                    : null;
        this.tgName                 = p.tgName              ?   p.tgName.toString()                 : null;
        this.invalid_destination    = p.invalid_destination ?   parseInt(p.invalid_destination)     : null;
        this.invalid_destdata       = p.invalid_destdata    ?   parseInt(p.invalid_destdata)        : null;
        this.invalid_destdata2      = p.invalid_destdata2   ?   p.invalid_destdata2.toString()      : null;
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
        this.tgID        = p.tgID         ?   parseInt(p.tgID)     : lookUp(API.us.Sequence, 'tgID').seqValue;
        return this;
    }
}
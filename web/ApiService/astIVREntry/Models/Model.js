class astIVRItemsModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.entry_id       = p.entry_id           ? parseInt(p.entry_id)           : null ;
        this.id_ivr_config  = p.id_ivr_config      ? parseInt(p.id_ivr_config)      : null ;
        this.extension      = p.extension          ? p.extension.toString()         : null ;
        this.return         = isBoolean(p.return)  ? Boolean(p.return)              : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.return         = isBoolean(p.return)  ? Boolean(p.return)   : null ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.entry_id       = p.entry_id           ? parseInt(p.entry_id)   : lookUp(API.us.Sequence, 'entry_id').seqValue;
        this.return         = isBoolean(p.return)  ? Boolean(p.return)      : null ;
         return this;
    }
}
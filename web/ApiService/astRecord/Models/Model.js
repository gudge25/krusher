class astRecordModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.record_id      = p.record_id           ? parseInt(p.record_id)         : null ;
        this.record_name    = p.record_name         ? p.record_name.toString()      : null ;
        this.record_source  = p.record_source       ? p.record_source.toString()    : null ;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)           : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.record_id      = p.record_id           ? parseInt(p.record_id)           : lookUp(API.us.Sequence, 'record_id').seqValue;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        return this;
    }
}
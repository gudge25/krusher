class regRegionModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.rgID       = parseInt(p.rgID)          ? parseInt(p.rgID)          : null ;
        this.rgName     = p.rgName                  ? p.rgName                  : null ;
        this.cID        = parseInt(p.cID)           ? parseInt(p.cID)           : null ;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)       : null ;
        this.langID     = p.langID                  ? p.langID  : null ;

     }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.cName        = p.cName                     ? p.cName                     : null ;
        return this;
    }
    post(){
        super.post();
        let p = this.p; delete this.p;
        this.rgID       = parseInt(p.rgID)    ? parseInt(p.rgID)        : lookUp(API.us.Sequence, 'rgID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        return this;
    }
}
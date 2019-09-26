class crmContactModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID       = p.clID  !== undefined   ? parseInt(p.clID)        : null;
        this.ccID       = p.ccID                  ? parseInt(p.ccID)        : null;
        this.ccName     = p.ccName                ? p.ccName.toString()     : null;
        this.ccType     = p.ccType                ? parseInt(p.ccType)      : null;
        this.ccStatus   = p.ccStatus              ? parseInt(p.ccStatus)    : null;
        this.ccComment  = p.ccComment             ? p.ccComment.toString()  : null;
        this.isPrimary  = isBoolean(p.isPrimary)  ? Boolean(p.isPrimary)    : null;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.regName        = p.regName;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ccID       = p.ccID                    ? parseInt(p.ccID)      : lookUp(API.us.Sequence, 'ccID').seqValue;
        this.isPrimary  = isBoolean(p.isPrimary)    ? Boolean(p.isPrimary)  : false ;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)   : true ;
        return this;
    }

    postFind(){
        let p = this.p; delete this.p; delete this.offset; delete this.limit; delete this.sorting; delete this.field;
        return this;
    }
}
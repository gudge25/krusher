class astSippeersModel extends BaseModelSIP {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.sipID          = p.sipID                   ? parseInt(p.sipID)     : null ;
        this.sipName        = p.sipName                 ? p.sipName.toString()  : null ;
        this.emID           = p.emID                    ? p.emID                : null ;
        this.sipType        = p.sipType                 ? parseInt(p.sipType)   : null ;
        this.isPrimary      = isBoolean(p.isPrimary)    ? Boolean(p.isPrimary)  : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.sipLogin       = p.sipLogin    ? p.sipLogin            : null ;
        this.sipPass        = p.sipPass     ? p.sipPass             : null ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.sipName        = p.sipName     ? p.sipName.toString()  : null ;
        this.callerid       = p.callerid    ? p.callerid            : this.sipName ;
        this.lines          = p.lines       ? p.lines               : 2 ;
        this.template       = p.template    ? p.template            : 'users' ;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.sipID          = p.sipID       ? p.sipID               : lookUp(API.us.Sequence, 'sipID').seqValue;
        this.sipName        = p.sipName     ? p.sipName.toString()  : null ;
        this.callerid       = p.callerid    ? p.callerid            : this.sipName.toString() ;
        this.lines          = p.lines       ? p.lines               : 2 ;
        this.template       = p.template    ? p.template            : 'users' ;
        return this;
    }
}
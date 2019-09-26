class astCustomDestinationModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.cdID               = p.cdID                ? parseInt(p.cdID)          : null ;
        this.cdName             = p.cdName              ? p.cdName.toString()       : null ;
        this.context            = p.context             ? p.context.toString()      : null ;
        this.exten              = p.exten               ? p.exten.toString()        : null ;
        this.priority           = p.priority            ? parseInt(p.priority)      : null ;
        this.description        = p.description         ? p.description.toString()  : null ;
        this.notes              = p.notes               ? p.notes.toString()        : null ;
        this.return             = isBoolean(p.return)   ? Boolean(p.return)         : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.return             = isBoolean(p.return)   ? Boolean(p.return)         : true ;
        this.exten              = p.exten               ? p.exten.toString()        : `\${EXTEN}` ;
        this.priority           = p.priority            ? parseInt(p.priority)      : 1 ;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.cdID               = p.cdID                ? p.cdID                    : lookUp(API.us.Sequence, 'cdID').seqValue;
        this.return             = isBoolean(p.return)   ? Boolean(p.return)         : true ;
        this.exten              = p.exten               ? p.exten.toString()        : `\${EXTEN}` ;
        this.priority           = p.priority            ? parseInt(p.priority)      : 1 ;
        return this;
    }
}
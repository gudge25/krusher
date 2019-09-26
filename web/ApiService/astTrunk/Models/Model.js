class astTrunkModel extends BaseModelSIP {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.trID               = p.trID                ? parseInt(p.trID)      : null ;
        this.trName             = p.trName              ? p.trName              : null ;
        this.host               = p.host                ? p.host                : null ;
        this.fromuser           = p.fromuser            ? p.fromuser            : null ;
        this.fromdomain         = p.fromdomain          ? p.fromdomain          : null ;
        this.callbackextension  = p.callbackextension   ? p.callbackextension   : null ;
        this.port               = parseInt(p.port)      ? parseInt(p.port)      : null ;
        this.isServer           = isBoolean(p.isServer) ? Boolean(p.isServer)   : null ;
        this.type               = p.type                ? p.type                : null ;
        this.directmedia        = p.directmedia         ? p.directmedia         : null ;
        this.insecure           = p.insecure            ? p.insecure            : null ;
        this.outboundproxy      = p.outboundproxy       ? p.outboundproxy       : null ;
        this.acl                = p.acl                 ? p.acl                 : null ;
        this.defaultuser        = p.defaultuser         ? p.defaultuser         : null ;
        this.DIDs               = p.DIDs                ? p.DIDs                : null ;
        this.ManageID           = p.ManageID            ? parseInt(p.ManageID)  : null ;
        this.coID               = p.coID                ? parseInt(p.coID)      : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.DIDs                 = p.DIDs                            ? p.DIDs.split(",").map( a => a.toString() )                         : [] ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.trName             = p.trName              ? p.trName              : null ;
        this.callerid           = p.callerid            ? p.callerid            : this.trName ;
        this.type               = isInteger(p.type)     ? parseInt(p.type)      : 102101 ;
        this.directmedia        = isInteger(p.directmedia)   ? parseInt(p.directmedia)  : 102006 ;
        this.port               = isInteger(p.port)     ? parseInt(p.port)      : 5060 ;
        this.host               = p.host                ? p.host                : null ;
        this.insecure           = p.insecure            ? p.insecure            : 101903;
        this.lines              = p.lines               ? p.lines               : 1 ;
        this.DIDs               = p.DIDs                ? p.DIDs                : [] ;
        this.template               = p.template                ? p.template                : 'peers' ;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.trID               = p.trID                ? p.trID                : lookUp(API.us.Sequence, 'trID').seqValue;
        this.trName             = p.trName              ? p.trName              : null ;
        this.callerid           = p.callerid            ? p.callerid            : this.trName ;
        this.type               = isInteger(p.type)     ? parseInt(p.type)      : 102101 ;
        this.directmedia        = isInteger(p.directmedia) ? parseInt(p.directmedia)    : 102006 ;
        this.host               = p.host                ? p.host                : null ;
        this.lines              = p.lines               ? p.lines               : 1 ;
        this.DIDs               = p.DIDs                ? p.DIDs                : [] ;
        this.template               = p.template                ? p.template                : 'peers' ;
        return this;
    }
}
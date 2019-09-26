class regValidationModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.vID                = p.vID                 ? parseInt(p.vID)       : null ;
        this.prefix             = p.prefix              ? p.prefix              : null ;
        this.prefixBegin        = p.prefixBegin         ? p.prefixBegin         : null ;
        this.prefixEnd          = p.prefixEnd           ? p.prefixEnd           : null ;
        this.MCC                = p.MCC                 ? p.MCC                 : null ;
        this.MNC                = p.MNC                 ? p.MNC                 : null ;
        this.gmt                = p.gmt                 ? p.gmt                 : null ;
        this.isGSM              = isBoolean(p.isGSM)    ? Boolean(p.isGSM)      : null ;
        this.isActive           = isBoolean(p.isActive) ? Boolean(p.isActive)   : null ;
        this.cID                = p.cID                 ? parseInt(p.cID)       : null ;
        this.rgID               = p.rgID                ? parseInt(p.rgID)      : null ;
        this.aID                = p.aID                 ? parseInt(p.aID)       : null ;
        this.lID                = p.lID                 ? parseInt(p.lID)       : null ;
        this.oID                = p.oID                 ? parseInt(p.oID)       : null ;
        this.phone              = p.phone               ? p.phone               : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.vID                = p.vID                 ? parseInt(p.vID)       : lookUp(API.us.Sequence, 'vID').seqValue;
        this.isGSM              = isBoolean(p.isGSM)    ? Boolean(p.isGSM)      : false ;
        this.isActive           = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        this.prefixBegin        = p.prefixBegin         ? p.prefixBegin         : 0 ;
        this.prefixEnd          = p.prefixEnd           ? p.prefixEnd           : 9999999 ;

        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        this.isGSM              = isBoolean(p.isGSM)    ? Boolean(p.isGSM)      : false ;
        this.isActive           = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        this.prefixBegin        = p.prefixBegin         ? p.prefixBegin         : 0 ;
        this.prefixEnd          = p.prefixEnd           ? p.prefixEnd           : 9999999 ;
        return this;
    }
}
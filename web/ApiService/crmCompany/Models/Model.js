class crmCompanyModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.coID           = p.coID                        ? parseInt(p.coID)              : null ;
        this.coName         = p.coName                      ? p.coName.toString()           : null ;
        this.coDescription  = p.coDescription               ? p.coDescription.toString()    : null ;
        this.inMessage      = p.inMessage                   ? p.inMessage.toString()        : null ;
        this.outMessage     = p.outMessage                  ? p.outMessage.toString()       : null ;
        this.pauseDelay     = p.pauseDelay                  ? parseInt(p.pauseDelay)        : null ;
        this.isActivePOPup  = isBoolean(p.isActivePOPup)    ? Boolean(p.isActivePOPup)      : null ;
        this.isRingingPOPup = isBoolean(p.isRingingPOPup)   ? Boolean(p.isRingingPOPup)     : null ;
        this.isUpPOPup      = isBoolean(p.isUpPOPup)        ? Boolean(p.isUpPOPup)          : null ;
        this.isCCPOPup      = isBoolean(p.isCCPOPup)        ? Boolean(p.isCCPOPup)          : null ;
        this.isClosePOPup   = isBoolean(p.isClosePOPup)     ? Boolean(p.isClosePOPup)       : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.coID           = p.coID            ? parseInt(p.coID)              : lookUp(API.us.Sequence, 'coID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isActivePOPup  = isBoolean(p.isActivePOPup)    ? Boolean(p.isActivePOPup)      : null ;
        this.isRingingPOPup = isBoolean(p.isRingingPOPup)   ? Boolean(p.isRingingPOPup)     : null ;
        this.isUpPOPup      = isBoolean(p.isUpPOPup)        ? Boolean(p.isUpPOPup)          : null ;
        this.isCCPOPup      = isBoolean(p.isCCPOPup)        ? Boolean(p.isCCPOPup)          : null ;
        this.isClosePOPup   = isBoolean(p.isClosePOPup)     ? Boolean(p.isClosePOPup)       : null ;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        delete this.inMessage; delete this.outMessage; 
        return this;
    }
}
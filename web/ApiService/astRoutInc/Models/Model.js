class astRouteIncModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.rtID               = p.rtID                        ? parseInt(p.rtID)              : null ;
        this.trID               = p.trID                        ? parseInt(p.trID)              : null ;
        this.DID                = p.DID                         ? p.DID.toString()              : null ;
        this.exten              = p.exten                       ? p.exten.toString()            : null ;
        this.context            = p.context                     ? p.context.toString()          : null ;
        this.callerID           = p.callerID                    ? p.callerID.toString()          : null ;
        this.isCallback         = isBoolean(p.isCallback)       ? Boolean(p.isCallback)         : null ;
        this.isFirstClient      = isBoolean(p.isFirstClient)    ? Boolean(p.isFirstClient)      : null ;
        this.stick_destination  = p.stick_destination           ? parseInt(p.stick_destination) : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.context            = p.context                     ? p.context.toString()          : `incoming` ;
        this.isCallback         = isBoolean(p.isCallback)       ? Boolean(p.isCallback)         : false;
        this.isFirstClient      = isBoolean(p.isFirstClient)    ? Boolean(p.isFirstClient)      : true ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.rtID               = p.rtID                        ? p.rtID                        : lookUp(API.us.Sequence, 'rtID').seqValue;
        this.context            = p.context                     ? p.context.toString()          : `incoming` ;
        this.isCallback         = isBoolean(p.isCallback)       ? Boolean(p.isCallback)         : false;
        this.isFirstClient      = isBoolean(p.isFirstClient)    ? Boolean(p.isFirstClient)      : true ;
        return this;
    }
}
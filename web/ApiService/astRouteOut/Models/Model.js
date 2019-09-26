class astRouteOutModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p                   = p;
        this.roID                = p.roID                   ?   parseInt(p.roID)        : null;
        this.roName              = p.roName                 ?   p.roName.toString()     : null;
        this.priority            = p.priority               ?   parseInt(p.priority)    : null;
        this.callerID            = p.callerID               ?   p.callerID.toString()   : null;
        this.category            = p.category               ?   parseInt(p.category)    : null;
        this.prefix              = p.prefix                 ?   p.prefix.toString()     : null;
        this.prepend             = p.prepend                ?   p.prepend.toString()    : null;
        this.coID                = p.coID                   ?   parseInt(p.coID)        : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.category            = p.category               ?   parseInt(p.category)              : 102602;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.roID                = p.roID                   ?   parseInt(p.roID)                  : lookUp(API.us.Sequence, 'roID').seqValue;
        this.category            = p.category               ?   parseInt(p.category)              : 102602;
        return this;
    }
}
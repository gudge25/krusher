class astRouteOutItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p                   = p;
        this.roiID               = p.roiID                  ?   parseInt(p.roiID)       : null;
        this.roID                = p.roID                   ?   parseInt(p.roID)        : null;
        this.pattern             = p.pattern                ?   p.pattern               : null;
        this.callerID            = p.callerID               ?   p.callerID.toString()   : null;
     }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.pattern             = p.pattern                  ? p.pattern.split(",")       : [] ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.pattern              = p.pattern                  ?   p.pattern.toString()    : null;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.roiID                = p.roiID                    ?   parseInt(p.roiID)        : lookUp(API.us.Sequence, 'roiID').seqValue;
        this.pattern              = p.pattern                  ?   p.pattern.split(",")     : null;
        return this;
    }
}
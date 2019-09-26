class astQueueMemberModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
        this.membername     = p.membername          ? p.membername          : null ;
        this.queue_name     = p.queue_name          ? p.queue_name          : null ;
        this.interface      = p.interface           ? p.interface           : null ;
        this.penalty        = parseInt(p.penalty)   ? parseInt(p.penalty)   : null ;
        this.paused         = parseInt(p.paused)    ? parseInt(p.paused)    : null ;
        this.quemID         = p.quemID              ? parseInt(p.quemID)    : null ;
        this.emID           = p.emID                ? parseInt(p.emID)      : null ;
        this.queID          = p.queID               ? parseInt(p.queID)     : null ;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.emID           = p.emID                ? p.emID                : null ;
        this.penalty        = parseInt(p.penalty)   ? parseInt(p.penalty)   : 0 ;
        this.paused         = parseInt(p.paused)    ? parseInt(p.paused)    : 0 ;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;

        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.quemID         = p.quemID              ? p.quemID              : lookUp(API.us.Sequence, 'quemID').seqValue;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        this.emID           = p.emID                ? p.emID                : null ;
        this.penalty        = parseInt(p.penalty)   ? parseInt(p.penalty)   : 0 ;
        this.paused         = parseInt(p.paused)    ? parseInt(p.paused)    : 0 ;
        return this;
    }
}
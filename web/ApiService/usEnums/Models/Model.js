class usEnumsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.tvID       = p.tvID                ? p.tvID                : null ;
        this.tyID       = p.tyID                ? p.tyID                : null ;
        this.Name       = p.Name                ? p.Name                : null ;
        this.isActive   = isBoolean(p.isActive) ? Boolean(p.isActive)   : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.NameT = p.Name;
        if( this.tvID != 101314 & this.tvID != 101315) return this;

    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        this.tvID           = p.tvID                ? p.tvID                : lookUp(API.us.Sequence, 'tvID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isActive       = isBoolean(p.isActive) ? Boolean(p.isActive)   : true ;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        this.limit      = p.limit   ? p.limit   : 1000 ;
        return this;
    }
}
class usCommentsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.uID        = p.uID     ? p.uID        : null;
        this.uComment   = p.uComment;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.id         = p.id;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : true ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.HIID;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : true ;
        return this;
    }
}
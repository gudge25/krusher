class fsBasesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dbID       = p.dbID;
        this.dbName     = p.dbName              ? p.dbName              : null ;
        this.dbPrefix   = p.dbPrefix            ? p.dbPrefix            : null ;
        this.activeTo   = p.activeTo            ? p.activeTo            : null ;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.dbID       = p.dbID                ? p.dbID                : 1 ;
        this.activeTo   = p.activeTo            ? p.activeTo            : `18:00:00` ;
        return this;
    }

    post(){
        super.post();
        delete this.p;
        this.dbID       = lookUp(API.us.Sequence, 'dbID').seqValue ;
        return this;
    }
}
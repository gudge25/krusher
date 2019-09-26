class StatusModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.isActive;
        this.clID       = p.clID;
        this.clStatus   = p.clStatus    ? p.clStatus    : null ;
        this.isFixed    = (p.isFixed !== undefined)     ? p.isFixed     : true ;
        return this;
    }
}
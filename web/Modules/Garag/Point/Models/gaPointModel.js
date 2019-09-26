class gaPointModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;

        this.pntID      = p.pntID;
        this.pntName    = p.pntName;
        this.isActive   = p.isActive;
        return this;
    }

    put(){
        super.put();
        var p = this.p; delete this.p;

        this.HIID       = p.HIID;
        this.pntID      = p.pntID;
        this.pntName    = p.pntName;
        this.isActive   = p.isActive;
        return this;
    }

    post(){
        super.post();
        var p = this.p; delete this.p;

        this.drvID      = p.drvID       ? p.drvID       : lookUp(API.us.Sequence, 'drvID').seqValue; ;
        this.drvName    = p.drvName     ? p.drvName     : null ;
        this.isActive   = p.isActive    ? p.isActive    : true ;
        return this;
    };
}
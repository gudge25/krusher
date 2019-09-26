class gaCarModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;

        this.carID      = p.carID;
        this.carName    = p.carName;
        this.carNo      = p.carNo;
        this.isActive   = p.isActive;
        return this;
    }

    put(){
        super.put();
        var p = this.p; delete this.p;

        this.HIID       = p.HIID;
        this.carID      = p.carID;
        this.carName    = p.carName;
        this.carNo      = p.carNo;
        this.isActive   = p.isActive;
        return this;
    }

    post(){
        super.post();
        var p = this.p; delete this.p;

        this.carID      = p.carID       ? p.carID       : lookUp(API.us.Sequence, 'carID').seqValue;
        this.carName    = p.carName     ? p.carName     : null ;
        this.carNo      = p.carNo       ? p.carNo       : null ;
        this.isActive   = p.isActive    ? p.isActive    : true ;
        return this;
    };
}
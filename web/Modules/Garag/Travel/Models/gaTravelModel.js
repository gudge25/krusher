class gaTravelModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;

        this.trID       = p.trID;
        this.dcID       = p.dcID;
        this.InDate     = p.InDate;
        this.InPoint    = p.InPoint;
        this.InWeight   = p.InWeight;
        this.OutDate    = p.OutDate;
        this.OutPoint   = p.OutPoint;
        this.OutWeigth  = p.OutWeigth;
        this.wbNo       = p.wbNo;
        this.trPrice    = p.trPrice;
        this.trCost     = p.trCost;
        return this;
    }

    put(){
        super.put();
        var p = this.p; delete this.p;

        this.trID       = p.trID;
        this.dcID       = p.dcID;
        this.InDate     = p.InDate;
        this.InPoint    = p.InPoint;
        this.InWeight   = p.InWeight;
        this.OutDate    = p.OutDate;
        this.OutPoint   = p.OutPoint;
        this.OutWeigth  = p.OutWeigth;
        this.wbNo       = p.wbNo;
        this.trPrice    = p.trPrice;
        this.trCost     = p.trCost;
        return this;
    }

    post(){
        super.post();
        var p = this.p; delete this.p;

        this.trID       = p.trID        ? p.trID        : lookUp(API.us.Sequence, 'trID').seqValue;
        this.dcID       = p.dcID        ? p.dcID        : null ;
        this.InDate     = p.InDate      ? p.InDate      : null ;
        this.InPoint    = p.InPoint     ? p.InPoint     : null ;
        this.InWeight   = p.InWeight    ? p.InWeight    : null ;
        this.OutDate    = p.OutDate     ? p.OutDate     : null ;
        this.OutPoint   = p.OutPoint    ? p.OutPoint    : null ;
        this.OutWeigth  = p.OutWeigth   ? p.OutWeigth   : null ;
        this.wbNo       = p.wbNo        ? p.wbNo        : null ;
        this.trPrice    = p.trPrice     ? p.trPrice     : null ;
        this.trCost     = p.trCost      ? p.trCost      : null ;
        return this;
    };
}

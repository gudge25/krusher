class sfInvoiceItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dcID           = p.dcID ? p.dcID : null;
        this.iiID           = p.iiID;
        this.OwnerID        = p.OwnerID     ? p.OwnerID     : null;
        this.psID           = p.psID        ? p.psID        : null;
        this.iName          = p.iName       ? p.iName       : null;
        this.iQty           = p.iQty        ? p.iQty        : null;
        this.iPrice         = p.iPrice      ? p.iPrice      : null;
        this.iComments      = p.iComments   ? p.iComments   : null;
        this.iNo            = p.iNo         ? p.iNo         : null;
    }

    post(){
        super.post();
        delete this.p.isToday;
        let p = this.p; delete this.p;
        this.iiID           = p.iiID ? p.iiID : lookUp(API.us.Sequence, 'iiID').seqValue;
        return this;
    }

    put(){
        super.get();
        let p = this.p; delete this.p;
        this.isToday        = p.isToday;
        return this;
    }
}
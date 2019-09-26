class slDealItemsModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.iPrice  = p.iPrice     ? p.iPrice      : null ;
        this.iQty    = p.iQty       ? p.iQty        : null ;
        this.ftiID   = p.ftiID      ? p.ftiID       : null ;
        this.psName  = p.psName     ? p.psName      : null ;
        this.diID    = p.diID       ? p.diID        : null ;
        this.psID    = p.psID       ? p.psID        : null ;

        delete this.dcComment;
        delete this.dcSum;
        delete this.dcStatus;
        delete this.clID;
        delete this.emID;
        delete this.dcDate;
        delete this.dcNo;
        delete this.dcLink;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.iPrice  = p.iPrice     ? p.iPrice      : 1 ;
        this.iQty    = p.iQty       ? p.iQty        : 1 ;
        delete this.ftiID;
        return this;
    }

    post(){
        let p = this.p; delete this.p;
        delete this.ftiID;
        this.diID    = lookUp(API.us.Sequence, 'diID').seqValue;
        this.iPrice  = p.iPrice     ? p.iPrice      : 1 ;
        this.iQty    = p.iQty       ? p.iQty        : 1 ;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        delete this.ftiID;
        return this;
    }
}
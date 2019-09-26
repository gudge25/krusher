class slDealModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        //this.dcNo       = p.dcID        ? p.dcID    : null;
        this.HasDocNo   = p.HasDocNo;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)       : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.isHasDoc = p.isHasDoc;
        this.ccName   = p.ccName;
        this.LinkFile = p.LinkFile;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.HasDocNo 	= p.HasDocNo                 ? p.HasDocNo        : new Date().getTime().toString() ;
        this.isActive   = isBoolean(p.isActive)      ? Boolean(p.isActive)       : true ;
        this.dcNo       = 'СД-' + p.dcID;
        return this;
    }
}
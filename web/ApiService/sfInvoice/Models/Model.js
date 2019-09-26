class sfInvoiceModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dcNo         = 'РХ-' + this.dcID;
        this.VATSum       = p.VATSum    ?  this.VATSum              : null;
        this.Delivery     = p.Delivery  ?  this.Delivery.toString() : null;
        //delete this.dcLink;
        //delete this.dcComment;
        //delete this.dcSum;
        //delete this.dcStatus;
        //delete this.clID;
        //delete this.emID;
        //delete this.dcDate;
        delete this.dcNo;
        delete this.offset;
        delete this.limit;
        delete this.sorting;
        delete this.field;
    }

    post(){
        super.post(); 
        let p = this.p; delete this.p.isToday; delete this.p;
        this.dcNo         = this.dcNo ?  this.dcNo : 'РХ-' + this.dcID;
        this.VATSum       = p.VATSum    ?  this.VATSum              : 0;
        return this;
    }

        
    put(){
        super.put();
        let p = this.p; delete this.p;  
        this.dcNo         = this.dcNo ?  this.dcNo : 'РХ-' + this.dcID;
        this.VATSum       = p.VATSum    ?  this.VATSum              : 0;
        return this;
    }

    
}
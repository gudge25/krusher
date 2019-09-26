class fmFormsItemsModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.fiID       = p.fiID        ? parseInt(p.fiID)           : null ;
        this.qID        = p.qID         ? parseInt(p.qID)           : null ;
        this.qName      = p.qName       ? p.qName.toString()        : null ;
        this.qiID       = p.qiID        ? parseInt(p.qiID)          : null ;
        this.qiAnswer   = p.qiAnswer    ? p.qiAnswer.toString()     : null ;
        this.qiComment  = p.qiComment   ? p.qiComment.toString()    : null ;
    }

    put(){
        super.post();
        let p = this.p; delete this.p;
        this.fiID       = p.fiID        ?  parseInt(p.fiID) : lookUp(API.us.Sequence, 'fiID').seqValue        ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        delete this.dcSum;
        delete this.dcNo;
        delete this.dcDate;
        delete this.dcLink;
        delete this.dcComment;
        delete this.dcStatus;
        delete this.clID;
        delete this.emID;
        delete this.HIID;
        this.fiID       = p.fiID        ?  parseInt(p.fiID) : lookUp(API.us.Sequence, 'fiID').seqValue        ;
        return this;
    }

    postFind(){
       // super.post();
        let p = this.p; delete this.p;
        delete this.dcSum;
        delete this.dcNo;
        delete this.dcDate;
        delete this.dcLink;
        delete this.dcComment;
        delete this.dcStatus;
        delete this.clID;
        delete this.emID;
        delete this.HIID;
        return this;
    }
}
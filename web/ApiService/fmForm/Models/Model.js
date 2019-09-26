class fmFormsModel extends BaseModelDC {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;
        this.Items      = p.Items           ? p.Items           : []  ;
        return this;
    }

    put(){
        super.post();
        let p = this.p; delete this.p;
        this.dcComment  = p.dcComment       ? p.dcComment.toString(): null ;
        this.dcLink     = p.dcLink          ? parseInt(p.dcLink)    : null ;
        this.dcNo       = p.dcNo            ? p.dcNo.toString()     : null ;
        this.dcStatus   = p.dcStatus        ? 1                     : 0  ;
        this.emID       = p.emID            ? parseInt(p.emID)      : EMID ;
        this.dcDate     = p.dcDate          ? p.dcDate              : null ;
        this.tpID       = p.tpID            ? parseInt(p.tpID)      : null ;
        return this;
    }

    post(){
       // super.post();
        let p = this.p; delete this.p;
        delete this.dcSum;
        delete this.Items;
        this.dcComment  = p.dcComment       ? p.dcComment           : null ;
        this.dcID       = p.dcID            ? parseInt(p.dcID)      : lookUp(API.us.Sequence, 'dcID').seqValue;
        this.dcLink     = p.dcLink          ? parseInt(p.dcLink)    : null ;
        this.dcNo       = p.dcNo            ? 'СД-' + p.dcID        : null ;
        this.dcStatus   = p.dcStatus        ? 1                     : 0  ;
        this.emID       = p.emID            ? parseInt(p.emID)      : EMID ;
        this.dcDate     = p.dcDate          ? p.dcDate              : null ;
        this.tpID       = p.tpID            ? parseInt(p.tpID)      : null ;
        return this;
    }

    postFind(){
       // super.post();
        let p = this.p; delete this.p;
        delete this.dcSum;
        delete this.Items;
        delete this.dcLink;
        delete this.dcComment;
        delete this.dcSum;
        delete this.dcStatus;
        delete this.clID;
        delete this.emID;
        delete this.dcDate;
        delete this.dcNo;
        this.dcComment  = p.dcComment       ? p.dcComment.toString()        : null ;
        this.dcLink     = p.dcLink          ? p.dcLink.toString()           : null ;
        this.dcNo       = p.dcNo            ? p.dcNo.toString()             : null ;
        this.dcStatus   = p.dcStatus        ? 1                             : 0  ;
        this.emID       = p.emID            ? parseInt(p.emID)              : null ;
        this.dcDate     = p.dcDate          ? p.dcDate                      : null ;
        this.tpID       = p.tpID            ? parseInt(p.tpID)              : null ;
        return this;
    }

    ans(){
        let p = this.p; delete this.p;
        this.qiID       = p.qiID            ? parseInt(p.qiID)            : null ;
        this.qID        = p.qID             ? parseInt(p.qID)             : null ;
        this.qiAnswer   = p.qiAnswer        ? parseInt(p.qiAnswer)        : null ;
        this.fiID       = lookUp(API.us.Sequence, 'fiID').seqValue;
        this.qName      = p.qName           ? p.qiComment.qName()      : null;
        this.qiComment  = p.qiComment       ? p.qiComment.toString()      : null;
        return this;
    }
}
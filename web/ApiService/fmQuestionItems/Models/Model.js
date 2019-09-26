class fmQuestionItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.qiID       = p.qiID !== undefined  ? parseInt(p.qiID)      : null ;
        this.qiAnswer   = p.qiAnswer            ? p.qiAnswer.toString() : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.tpID       = p.tpID                ? parseInt(p.tpID)      : null ;
        this.qID        = p.qID !== undefined   ? parseInt(p.qID)       : null ;

        
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.qiID       = p.qiID                ? parseInt(p.qiID)      : lookUp(API.us.Sequence, 'qiID').seqValue;
        this.qID        = p.qID                 ? parseInt(p.qID)       : null ;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        this.qIDs          = p.qIDs                                       ? p.qIDs                                                   : [] ;
        //this.dcIDs          = p.dcIDs !== undefined                         ? p.dcIDs.map( x =>  x.dcID )                               : [] ;        
        return this;
    }
}
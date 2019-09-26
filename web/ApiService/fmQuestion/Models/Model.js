class fmQuestionsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.qID        = p.qID;
        this.qName      = p.qName               ? p.qName               : null;
        this.ParentID   = p.ParentID            ? p.ParentID            : null;
        this.tpID       = p.tpID                ? p.tpID                : null;

    }

    get(){
        super.get();
        let p = this.p; delete this.p;
         this.Items      = p.Items;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.qID        = lookUp(API.us.Sequence, 'qID').seqValue ;
        return this;
    }
}
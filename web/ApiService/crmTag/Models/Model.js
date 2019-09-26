class crmTagModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.tagID          = p.tagID;
        this.tagDesc        = p.tagDesc;
        this.tagName        = p.tagName;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.Qty          = p.Qty   ? p.Qty        : null;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.tagID          = p.tagID   ? p.tagID        : lookUp(API.us.Sequence, 'tagID').seqValue;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }
}
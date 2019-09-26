class fsTemplatesItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ftiID      = p.ftiID;
        this.ftID       = p.ftID;
        this.ftType     = p.ftType;
        this.ColNumber  = p.ColNumber;
        this.ftDelim    = p.ftDelim ? p.ftDelim : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.ftTypeName = p.ftType ? p.ftTypeName    : null; //BUG !!! lookUp(API.us.Enums, p.ftType).Name;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.ftiID      = p.ftiID;
        this.ftID       = p.ftID;
        this.ftType     = p.ftType;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ftiID      = p.ftiID ? p.ftiID : lookUp(API.us.Sequence, 'ftiID').seqValue;
        return this;
    }

    postFind(){
        let p = this.p; delete this.p; delete this.ftiID; delete this.ftDelim;
        return this;
    }
}
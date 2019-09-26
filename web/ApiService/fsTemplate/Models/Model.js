class fsTemplatesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ftID      = p.ftID     ? p.ftID        : null;
        this.ftName    = p.ftName   ? p.ftName      : null;
        this.delimiter = p.delimiter? p.delimiter   : null;
        this.Encoding  = p.Encoding ? p.Encoding    : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.items     = [];
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ftID      = p.ftID         ? p.ftID : lookUp(API.us.Sequence, 'ftID').seqValue;
        this.delimiter = p.delimiter? p.delimiter   : ";";
        this.Encoding  = p.Encoding ? p.Encoding    : "utf8";
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.delimiter = p.delimiter? p.delimiter   : ";";
        this.Encoding  = p.Encoding ? p.Encoding    : "utf8";
        return this;
    }

    postFind(){
        //super.put();
        let p = this.p; delete this.p; delete this.HIID;
        return this;
    }
}